local map = require('utils').map

return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                css = { 'dprint', 'prettierd', 'prettier', stop_after_first = true, },
                go = { 'goimports', 'gofmt' },
                graphql = { 'prettierd', 'prettier', stop_after_first = true, },
                html = { 'prettierd', 'prettier', stop_after_first = true, },
                javascript = { 'prettierd', 'prettier', stop_after_first = true, },
                javascriptreact = { 'prettierd', 'prettier', stop_after_first = true, },
                json = { 'prettierd', 'prettier', stop_after_first = true, },
                lua = { 'stylua' },
                markdown = { 'prettierd', 'prettier', stop_after_first = true, },
                python = { 'isort', 'black' },
                rust = { 'rustfmt' },
                sql = { 'sql-formatter' },
                svelte = { 'prettierd', 'prettier', stop_after_first = true, },
                typescript = { 'prettierd', 'prettier', stop_after_first = true, },
                typescriptreact = { 'prettierd', 'prettier', stop_after_first = true, },
                yaml = { 'prettier' },
            },
        })

        map({ 'n' }, '<leader>f', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = 'format file' })

        map({ 'v' }, '<leader>f', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = 'format selection' })

        vim.api.nvim_create_user_command('Format', function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ['end'] = { args.line2, end_line:len() },
                }
            end

            conform.format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })
    end,
}
