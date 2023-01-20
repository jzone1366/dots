return {
  'zegervdv/nrpattern.nvim',
  dependencies = {
      'tpope/vim-repeat',
  },
  event = 'BufWinEnter',
  config = function()
    require('zone.plugins.nrpattern.config')
  end,
}
