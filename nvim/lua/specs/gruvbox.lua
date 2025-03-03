local utils = require('utils')

return {
  'f4z3r/gruvbox-material.nvim',
  name = 'gruvbox-material',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    if utils.os_is_dark() then
      vim.cmd('set background=dark')
    else
      vim.cmd('set background=light')
    end
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_foreground = 'original'
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_better_performance = 1
    vim.cmd('colorscheme gruvbox-material')
  end,
}
