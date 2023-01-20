return {
  'folke/trouble.nvim',
  config = function()
    require('zone.plugins.trouble.config')
  end,
  event = 'BufEnter',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
}
