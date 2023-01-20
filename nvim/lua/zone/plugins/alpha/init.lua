return {
  'goolord/alpha-nvim',
  lazy = false,
  config = function()
    require('zone.plugins.alpha.config')
  end,
  dependencies = { 'kyazdani42/nvim-web-devicons' },
}
