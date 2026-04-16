-- ┌────────────────────┐
-- │ LSP config example │
-- └────────────────────┘
--
-- This file contains configuration of 'lua_ls' language server.
-- Source: https://github.com/LuaLS/lua-language-server
--
-- It is used by `:h vim.lsp.enable()` and `:h vim.lsp.config()`.
-- See `:h vim.lsp.Config` and `:h vim.lsp.ClientConfig` for all available fields.
--
-- This config is designed for Lua's activity around Neovim. It provides only
-- basic config and can be further improved.
return {
  on_attach = function(client, _)
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
  end,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      workspace = {
        ignoreSubmodules = true,
        library = {
          vim.env.VIMRUNTIME,
          -- picks up vim.* type annotations
          '${3rd}/luv/library',
        },
        checkThirdParty = false,
      },
      diagnostics = {
        globals = { 'vim', 'Config' },
      },
    },
  },
}
