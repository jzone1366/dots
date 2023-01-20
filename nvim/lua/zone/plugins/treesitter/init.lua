return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-refactor',
  },
  event = 'BufEnter',
  build = ':TSUpdate',
  config = function()
    require('zone.plugins.treesitter.config')
  end,
}
