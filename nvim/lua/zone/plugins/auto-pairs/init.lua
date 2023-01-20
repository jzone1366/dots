return {
  'windwp/nvim-autopairs',
  config = function()
    require('zone.plugins.auto-pairs')
  end,
  event = 'InsertEnter',
}
