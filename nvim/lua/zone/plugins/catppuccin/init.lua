return {
  { -- color scheme
    'catppuccin/nvim',
    lazy = false,
    config = function()
      local config = require('zone.plugins.catppuccin.config')
      require('catppuccin').setup(config)
      vim.cmd('color catppuccin')
    end,
  },
}
