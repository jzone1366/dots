return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
    require('zone.plugins.auto-session.config')
  end,
  init = function()
    require('zone.plugins.auto-session.mappings')
  end,
}
