return {
  'goolord/alpha-nvim',
  lazy = false,
  config = function()
    require('plugins.alpha-nvim.config')
  end,
  dependencies = { 'kyazdani42/nvim-web-devicons' },
}

