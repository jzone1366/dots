return {
  'norcalli/nvim-colorizer.lua',
  cmd = { 'ColorizerToggle' },
  config = function()
    require('zone.plugins.colorizer.config')
  end,
}
