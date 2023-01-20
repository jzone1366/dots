return {
  'stevearc/aerial.nvim',
  config = function()
    require('zone.plugins.aerial.config')
  end,
  event = 'BufEnter',
}
