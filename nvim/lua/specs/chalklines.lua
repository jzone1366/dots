return {
  'jzone1366/chalklines.nvim',
  dir = '~/workspace/personal/nvim/chalklines.nvim',
  enabled = false,
  priority = 1000,
  config = function()
    require('chalklines').setup({
      overrides = {},
    })
    vim.cmd('colorscheme chalklines')
  end,
}
