return {
  'folke/which-key.nvim',
  config = function()
    require('zone.plugins.whichkey.config')
  end,
  event = 'VeryLazy',
}
