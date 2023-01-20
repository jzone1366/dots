return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen' },
  config = function()
    require('zone.plugins.diffview.config')
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
