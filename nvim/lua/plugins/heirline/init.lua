return {
  'rebelot/heirline.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins.heirline.config')
  end,
  dependencies = {
    'catppuccin/nvim',
  },
}
