-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')
local ufo_config_handler = require('plugins.nvim-ufo').handler

if not mason_ok or not mason_lsp_ok then
  return
end

mason.setup({
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = SwiftVim.ui.float.border or 'rounded',
  },
})

mason_lsp.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    'bashls',
    'clangd',
    'cssls',
    'docker_compose_language_service',
    'dockerls',
    'emmet_ls',
    'eslint',
    'gopls',
    'graphql',
    'helm_ls',
    'html',
    'jsonls',
    'lua_ls',
    'jedi_language_server',
    'rust_analyzer',
    'sqlls',
    'tailwindcss',
    'terraformls',
    'vimls',
    'vtsls',
    'yamlls',
  },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

local lspconfig = require('lspconfig')

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = SwiftVim.ui.float.border,
  }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = SwiftVim.ui.float.border }),
  ['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = SwiftVim.lsp.virtual_text }
  ),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

require('mason-lspconfig').setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require('lspconfig')[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
    })
  end,

  ['tailwindcss'] = function()
    lspconfig.tailwindcss.setup({
      capabilities = require('core.lsp.servers.tailwindcss').capabilities,
      filetypes = require('core.lsp.servers.tailwindcss').filetypes,
      handlers = handlers,
      init_options = require('core.lsp.servers.tailwindcss').init_options,
      on_attach = require('core.lsp.servers.tailwindcss').on_attach,
      settings = require('core.lsp.servers.tailwindcss').settings,
    })
  end,

  ['cssls'] = function()
    lspconfig.cssls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = require('core.lsp.servers.cssls').on_attach,
      settings = require('core.lsp.servers.cssls').settings,
    })
  end,

  ['eslint'] = function()
    lspconfig.eslint.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = require('core.lsp.servers.eslint').on_attach,
      settings = require('core.lsp.servers.eslint').settings,
    })
  end,

  ['jsonls'] = function()
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
      settings = require('core.lsp.servers.jsonls').settings,
    })
  end,

  ['lua_ls'] = function()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
      settings = require('core.lsp.servers.lua_ls').settings,
    })
  end,

  ['vuels'] = function()
    lspconfig.vuels.setup({
      filetypes = require('core.lsp.servers.vuels').filetypes,
      handlers = handlers,
      init_options = require('core.lsp.servers.vuels').init_options,
      on_attach = require('core.lsp.servers.vuels').on_attach,
      settings = require('core.lsp.servers.vuels').settings,
    })
  end,
})

require('ufo').setup({
  fold_virt_text_handler = ufo_config_handler,
  close_fold_kinds_for_ft = { default = { 'imports' } },
})
