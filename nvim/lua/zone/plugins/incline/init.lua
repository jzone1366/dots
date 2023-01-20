return {
  'b0o/incline.nvim',
  event = 'BufEnter',
  config = function()
    require('zone.plugins.incline.config')
  end,
}

