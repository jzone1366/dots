return {
  enabled = true,
  'rebelot/heirline.nvim',
  event = 'VeryLazy',
  config = function()
    require('zone.plugins.heirline.config')
  end,
}
