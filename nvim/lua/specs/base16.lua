local utils = require('utils')

return {
  'RRethy/base16-nvim',
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    if utils.os_is_dark() then
      --vim.cmd('colorscheme base16-ayu-dark')
      vim.cmd('colorscheme base16-gruvbox-dark-hard')
    else
      --vim.cmd('colorscheme base16-ayu-light')
      vim.cmd('colorscheme base16-gruvbox-light-hard')
    end
  end,
}
