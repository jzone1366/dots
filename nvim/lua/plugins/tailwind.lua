return {
    {
        'MaximilianLloyd/tw-values.nvim',
        keys = {
            { '<Leader>cv', '<CMD>TWValues<CR>', desc = 'Tailwind CSS values' },
        },
        opts = {
            border = 'rounded',    -- Valid window border style,
            show_unknown_classes = true, -- Shows the unknown classes popup
        },
    },
    {
        'laytan/tailwind-sorter.nvim',
        cmd = {
            'TailwindSort',
            'TailwindSortOnSaveToggle',
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = true,
    },
}
