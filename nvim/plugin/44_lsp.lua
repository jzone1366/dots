-- ┌──────────────────┐
-- │ Language servers │
-- └──────────────────┘

local add, now_if_args, later = vim.pack.add, Config.now_if_args, Config.later

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
--
-- Per-server settings live in `after/lsp/<server>.lua`, which Neovim merges on
-- top of nvim-lspconfig's defaults automatically.
now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  local blink_caps = require('blink.cmp').get_lsp_capabilities()
  local servers = {
    'bashls',
    'cssls',
    'denols',
    'dockerls',
    'eslint',
    'gopls',
    'html',
    'intelephense',
    'jsonls',
    'lua_ls',
    'prismals',
    'pyright',
    'csharp_ls',
    'rust_analyzer',
    'sqlls',
    'svelte',
    'tailwindcss',
    'terraformls',
    'texlab',
    'ts_ls',
    --'tsgo', -- turn on later and use instead of ts_ls
    'vimls',
    'yamlls',
  }

  -- Apply to every server unless you override later
  vim.lsp.config('*', {
    capabilities = blink_caps,
  })

  local root_patterns = { '.git', 'deno.json', 'tsconfig.json', 'package.json', 'jsconfig.json', 'pyproject.toml' }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1] or vim.uv.cwd())

  -- Only enable servers whose executable is installed, so missing ones stay quiet.
  -- Servers with a function `cmd` can't be checked up front, so enable them anyway.
  local function is_installed(lsp)
    local cmd = (vim.lsp.config[lsp] or {}).cmd
    if type(cmd) ~= 'table' then return true end
    return vim.fn.executable(cmd[1]) == 1
  end

  -- Configure each LSP server
  for _, lsp in ipairs(servers) do
    -- Skip ts_ls if deno.json is present in the project root
    local skip_ts = lsp == 'ts_ls' and vim.fn.filereadable(root_dir .. '/deno.json') == 1
    if not skip_ts and is_installed(lsp) then
      vim.lsp.enable(lsp)
    end
  end
end)

-- Diagnostics ================================================================

later(function()
  add({ 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' })
  require('tiny-inline-diagnostic').setup({
    preset = 'modern',
    multilines = true,
  })
  vim.diagnostic.config({ virtual_text = false })
end)
