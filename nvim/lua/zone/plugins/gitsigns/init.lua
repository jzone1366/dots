return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opt = true,
  event = 'VeryLazy',
  config = function()
    require('zone.plugins.gitsigns.config')
  end,
}
