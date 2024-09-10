local utils = require('utils')

local config = {
    integrations = {
        alpha = true,
        mini = true,
        navic = {
            enabled = true,
            custom_bg = "NONE",
        },
        neotree = false,
        nvimtree = true,
        lsp_trouble = true,
        which_key = true,
    },
}

return {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
        require('catppuccin').setup(config)

        if utils.os_is_dark() then
            vim.cmd('color catppuccin-mocha')
        else
            vim.cmd('color catppuccin-latte')
        end
    end,
}
