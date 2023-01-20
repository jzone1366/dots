return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    require('zone.plugins.telescope.config')
  end,
  init = function()
    require('zone.plugins.telescope.mappings')
  end,
  cmd = { 'Telescope' },
  keys = {
    {
      '<leader>ff',
      '<cmd>lua require("zone.plugins.telescope.utils").project_files()<cr>',
      desc = 'Find project file',
    },
  },
}
