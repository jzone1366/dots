return {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
}
