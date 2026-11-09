-- ┌────────────────────────┐
-- │ Formatting and linting │
-- └────────────────────────┘

local add, later = vim.pack.add, Config.later

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    -- formatters_by_ft = { lua = { 'stylua' } },
    formatters_by_ft = {
      css = { 'prettierd', 'prettier', stop_after_first = true },
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
      tex = { 'latexindent' },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
    },
  })
end)

-- Linting ====================================================================

later(function()
  add({ 'https://github.com/mfussenegger/nvim-lint' })

  local lint = require('lint')

  lint.linters.luacheck.args = {
    '--config',
    vim.fn.stdpath('config') .. '/.luacheckrc',
    '--no-color',
    '--formatter',
    'plain',
    '--ranges',
  }

  lint.linters_by_ft = {
    javascript = {
      'eslint_d',
    },
    lua = {
      'luacheck',
    },
    markdown = {
      'vale',
    },
    php = {
      'phpcs',
    },
    python = {
      'pylint',
    },
    sh = {
      'shellcheck',
    },
    typescript = {
      'eslint_d',
    },
    typescriptreact = {
      'eslint_d',
    },
    tex = {
      'chktex',
    },
    yaml = {
      'yamllint',
    },
  }

  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      -- Only run linters that are installed, so missing ones don't warn
      local names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if type(linter) == 'function' then linter = linter() end
        local cmd = linter and linter.cmd
        if type(cmd) == 'function' then cmd = cmd() end
        return type(cmd) == 'string' and vim.fn.executable(cmd) == 1
      end, lint.linters_by_ft[vim.bo.filetype] or {})
      if #names > 0 then lint.try_lint(names) end
    end,
  })
end)
