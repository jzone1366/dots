local icons = require('swift.settings').icons
return {
  'SmiteshP/nvim-navic',
  config = function()
    local navic = require('nvim-navic')

    vim.api.nvim_set_hl(0, 'NavicText', { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'NavicSeparator', { link = 'Comment' })

    navic.setup({
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = true,
      separator = ' ' .. icons.misc.caret_right .. ' ',
      depth_limit = 0,
      depth_limit_indicator = '..',
      safe_output = true,
    })
  end,
  dependencies = {
    'neovim/nvim-lspconfig',
  },
}
