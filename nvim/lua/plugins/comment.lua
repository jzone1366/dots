return {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
        require('plugins.comment')
    end,
}
