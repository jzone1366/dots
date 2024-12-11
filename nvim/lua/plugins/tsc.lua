return {
  'dmmulroy/tsc.nvim',
  cmd = { 'TSC' },
  config = function()
    require('tsc').setup({
      use_trouble_qflist = true,
    })
  end,
}
