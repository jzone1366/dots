local lsp_status = require('lsp-status')
local lsp_installer = require('nvim-lsp-installer')
local user_lsp_status = require('zone.statusline.lsp')
local nvim_cmp_lsp = require('cmp_nvim_lsp')
local icons = require('zone.theme.icons')

lsp_installer.settings({
  ui = {
    keymaps = {
      -- Keymap to expand a server in the UI
      toggle_server_expand = 'i',
      -- Keymap to install a server
      install_server = '<CR>',
      -- Keymap to reinstall/update a server
      update_server = 'u',
      -- Keymap to uninstall a server
      uninstall_server = 'x',
    },
  },
})

local M = {
  fmt_on_save_enabled = false,
  border = { { '╭' }, { '─' }, { '╮' }, { '│' }, { '╯' }, { '─' }, { '╰' }, { '│' } },
  signs = {
    Error = icons.error .. ' ',
    Warn = icons.warn .. ' ',
    Hint = icons.hint .. ' ',
    Info = icons.info .. ' ',
  },
  on_attach_called = false,
}

local fmt_triggers = {
  default = 'BufWritePre',
  sh = 'BufWritePost',
}

local lsp_handlers = {
  ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --virtual_text = {
    --  source = 'if_many',
    --  severity = vim.diagnostic.severity.ERROR,
    --},
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
  }),

  ['textDocument/definition'] = function(_, result)
    if result == nil or vim.tbl_isempty(result) then
      print('Definition not found')
      return nil
    end
    local function jumpto(loc)
      local split_cmd = vim.uri_from_bufnr(0) == loc.targetUri and 'split' or 'tabnew'
      vim.cmd(split_cmd)
      vim.lsp.util.jump_to_location(loc)
    end

    if vim.tbl_islist(result) then
      jumpto(result[1])
      if #result > 1 then
        vim.fn.setqflist(vim.lsp.util.locations_to_items(result))
        vim.api.nvim_command('copen')
        vim.api.nvim_command('wincmd p')
      end
    else
      jumpto(result)
    end
  end,

  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = M.border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = M.border }),

  ['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
    vim.notify({ result.message }, lvl, {
      title = 'LSP | ' .. client.name,
      timeout = 10000,
      keep = function()
        return lvl == 'ERROR' or lvl == 'WARN'
      end,
    })
  end,
}

---- ray-x/lsp_signature.nvim
local lsp_signature_config = {
  zindex = 99, -- Keep signature popup below the completion PUM
}

local function on_attach(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    M.set_fmt_on_save(true, true)
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  user_lsp_status.on_attach(client, bufnr)
  require('aerial').on_attach(client, bufnr)
  if client.server_capabilities.codeActionProvider then
    local augid = vim.api.nvim_create_augroup('user_lsp_code_actions', { clear = true })
    local cal_dbounce = require('zone.utils.debounce').make(M.code_action_listener, { threshold = 500 })
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = bufnr,
      group = augid,
      callback = function(...)
        cal_dbounce(...)
      end,
    })
  end
  vim.schedule(function()
    require('zone.lsp.mappings').init(client, bufnr)
  end)
end

local function on_first_attach()
  require('null-ls').setup(vim.tbl_extend('force', require('zone.lsp.null-ls'), { on_attach = on_attach }))
  require('lsp_signature').setup(lsp_signature_config)
  --require('packer').loader('trouble.nvim', false)
end

local function on_attach_wrapper(...)
  if not M.on_attach_called then
    ---@diagnostic disable-next-line: redundant-parameter
    on_first_attach(...)
    M.on_attach_called = true
  end
  return on_attach(...)
end

local function on_exit(code, signal, id)
  user_lsp_status.on_exit(code, signal, id)
end

-- Enables/disables format on save
-- If val is nil, format on save is toggled
-- If silent is not false, a message will be displayed
function M.set_fmt_on_save(val, silent)
  M.fmt_on_save_enabled = val ~= nil and val or not M.fmt_on_save_enabled
  local augid = vim.api.nvim_create_augroup('user_lsp_fmt_on_save', { clear = true })
  if M.fmt_on_save_enabled then
    vim.api.nvim_create_autocmd(fmt_triggers[vim.o.filetype] or fmt_triggers.default, {
      callback = function()
        vim.lsp.buf.format(nil, 10000)
      end,
      group = augid,
    })
  end
  if not silent then
    print('Format on save ' .. (M.fmt_on_save_enabled and 'enabled' or 'disabled') .. '.')
  end
end

function M.peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
    if result == nil or vim.tbl_isempty(result) then
      return nil
    end
    vim.lsp.util.preview_location(result[1])
  end)
end

M.code_actions = {}
function M.code_action_listener()
  local bufnr = vim.api.nvim_get_current_buf()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  pcall(vim.lsp.buf_request, bufnr, 'textDocument/codeAction', params, function(err, actions, result)
    if err or not result or not result.bufnr then
      return
    end
    M.code_actions[result.bufnr] = M.code_actions[result.bufnr] or {}
    M.code_actions[result.bufnr][result.client_id] = actions and #actions or 0
    local count = 0
    for _, sub_count in ipairs(M.code_actions[result.bufnr]) do
      count = count + sub_count
    end
    M.code_actions[result.bufnr].count = count
  end)
end

local function lsp_init()
  vim.lsp.set_log_level('warn')
  for k, v in pairs(lsp_handlers) do
    vim.lsp.handlers[k] = v
  end
  for type, icon in pairs(M.signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  local capabilities = nvim_cmp_lsp.update_capabilities(lsp_status.capabilities)

  -- USE LSP INSTALLER
  lsp_installer.setup({
    automatic_installation = true,
  })
  local lspconfig = require('lspconfig')
  local lsp_servers = require('zone.lsp.servers')

  for _, lsp in ipairs(lsp_servers) do
    local opts = {
      on_attach = on_attach_wrapper,
      on_exit = on_exit,
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities,
    }
    local name = lsp
    if type(lsp) == 'table' then
      name = lsp[1]
      if lsp.formatting == false then
        lsp.formatting = nil
        opts.on_attach = function(client, ...)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          return on_attach(client, ...)
        end
      end
      for k, v in pairs(lsp) do
        if k ~= 1 then
          opts[k] = v
        end
      end
    else
      name = lsp
    end
    if not lspconfig[name] then
      error('LSP: Server not found: ' .. name)
    end
    lspconfig[name].setup(opts)
    lsp_status.register_progress()
    lsp_status.config({ current_function = false })
  end
end

lsp_init()

return M
