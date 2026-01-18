-- Conform formatting configuration for mini.deps
return function()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      css = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports', 'gofmt' },
      graphql = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      lua = { 'stylua' },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      python = { 'isort', 'black' },
      ruby = { 'rubocop', 'rubyfmt', stop_after_first = true },
      rust = { 'rustfmt' },
      sql = { 'sql-formatter' },
      svelte = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettier' },
    },
  })

  -- Setup keymapping for formatting
  vim.keymap.set('', '=', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
  end, { desc = 'Format buffer' })
end
