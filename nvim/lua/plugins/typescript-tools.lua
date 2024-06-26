local baseDefinitionHandler = vim.lsp.handlers['textDocument/definition']

local filter = require('core.lsp.utils.filter').filter
local filterReactDTS = require('core.lsp.utils.filterReactDTS').filterReactDTS

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
  ['textDocument/definition'] = function(err, result, method, ...)
    P(result)
    if vim.tbl_islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return baseDefinitionHandler(err, filtered_result, method, ...)
    end

    baseDefinitionHandler(err, result, method, ...)
  end,
}

require('typescript-tools').setup({
  on_attach = function(_, bufnr)
    if vim.fn.has('nvim-0.10') then
      -- Enable inlay hints
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end,
  handlers = handlers,
  settings = {
    separate_diagnostic_server = true,
    code_lens = 'off',
    tsserver_file_preferences = {
      includeInlayParameterNameHints = 'all',
      includeCompletionsForModuleExports = true,
      quotePreference = 'auto',
    },
  },
})
