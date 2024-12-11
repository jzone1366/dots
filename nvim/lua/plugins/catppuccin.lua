local utils = require('utils')

local config = {
  integrations = {
    alpha = true,
    dap = true,
    diffview = true,
    fidget = true,
    flash = true,
    lsp_trouble = true,
    mason = true,
    mini = {
      enabled = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
        ok = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
        ok = { 'underline' },
      },
      inlay_hints = {
        background = true,
      },
    },
    navic = {
      enabled = true,
      custom_bg = 'NONE',
    },
    notify = true,
  },
}

return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  enabled = true,
  compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
  config = function()
    require('catppuccin').setup(config)

    if utils.os_is_dark() then
      vim.cmd('color catppuccin-mocha')
    else
      vim.cmd('color catppuccin-latte')
    end
  end,
}
