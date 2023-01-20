return {
  'feline-nvim/feline.nvim',
  event = 'VeryLazy',
  config = function()
    require('zone.plugins.feline.config')
  end,
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    'lewis6991/gitsigns.nvim',
  },
}
