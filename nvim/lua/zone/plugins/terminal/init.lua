return {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermToggle', 'FloatermNew' },
  keys = {
    { '<C-l>', '<cmd>FloatermToggle<cr>', desc = 'Floating Terminal' },
  },
  config = function()
    require('zone.plugins.terminal.config')
  end,
}
