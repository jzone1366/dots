local M = {}

local filter = require('swift.utils').filter
local filterReactDTS = require('swift.utils').filterReactDTS

local on_attach = function(client, bufnr)
  -- Modifying a server's capabilities is not recommended and is no longer
  -- necessary thanks to the `vim.lsp.buf.format` API introduced in Neovim
  -- 0.8. Users with Neovim 0.7 needs to uncomment below lines to make tsserver formatting work (or keep using eslint).

  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('lsp-inlayhints').on_attach(client, bufnr)
end

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = 'rounded',
  }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  ['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = 'rounded' }
  ),
  ['textDocument/definition'] = function(err, result, method, ...)
    if vim.tbl_islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
    end

    vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
  end,
}

local settings = {
  typescript = {
    inlayHints = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = true,
    },
    suggest = {
      includeCompletionsForModuleExports = true,
    },
  },
  javascript = {
    inlayHints = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = true,
    },
    suggest = {
      includeCompletionsForModuleExports = true,
    },
  },
}

M.on_attach = on_attach
M.handlers = handlers
M.settings = settings

return M
