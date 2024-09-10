local map = require('utils').map

return {
    'mfussenegger/nvim-lint',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            go = { 'golangcilint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            svelte = { 'eslint_d' },
            python = { 'pylint' },
            lua = { 'selene', 'luacheck' },
            markdown = { 'markdownlint' },
        }

        map('n', '<leader>l', function()
            lint.try_lint()
        end, { desc = 'lint file' })
    end,
}
