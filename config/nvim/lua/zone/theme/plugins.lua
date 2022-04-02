local M = {}

M.supported_themes = {
  'ayu',
  'chalklines',
  'gruvbox',
  'kanagawa',
  'nightfox',
  'onedark',
  'rose-pine',
  'tokyonight',
  'twilight',
}

function M.init(use, config)
  use({
    'Shatur/neovim-ayu',
    as = 'ayu',
    config = function()
      vim.o.background = 'light'
      vim.cmd('color ayu-light')
    end,
    disable = config.theme ~= 'ayu',
  })

  use({
    '~/dev/chalklines',
    as = 'chalklines',
    config = function()
      vim.cmd('colorscheme chalklines')
    end,
    disable = config.theme ~= 'chalklines',
  })

  use({
    'ellisonleao/gruvbox.nvim',
    as = 'gruvbox',
    requires = { 'rktjmp/lush.nvim' },
    config = function()
      vim.o.background = 'dark'
      vim.cmd('color gruvbox')
    end,
    disable = config.theme ~= 'gruvbox',
  })

  use({
    'rebelot/kanagawa.nvim',
    as = 'kanagawa',
    config = function()
      vim.cmd('colorscheme kanagawa')
    end,
    disable = config.theme ~= 'kanagawa',
  })

  use({
    'EdenEast/nightfox.nvim',
    as = 'nightfox',
    config = function()
      vim.cmd('color dayfox')
    end,
    disable = config.theme ~= 'nightfox',
  })

  use({
    'navarasu/onedark.nvim',
    as = 'onedark',
    config = function()
      vim.cmd('color onedark')
    end,
    disable = config.theme ~= 'onedark',
  })

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.g.dark_variant = 'main'
      vim.o.background = 'light'
      vim.cmd('colorscheme rose-pine')
    end,
    disable = config.theme ~= 'rose-pine',
  })

  use({
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = 'day'
      vim.g.tokyonight_sidebars = { 'qf' }
      vim.cmd('color tokyonight')
    end,
    disable = config.theme ~= 'tokyonight',
  })

  use({
    '~/dev/twilight',
    --'jzone1366/twilight.nvim',
    as = 'twilight',
    config = function()
      require('twilight').load('light')
    end,
    disable = config.theme ~= 'twilight',
  })
end

return M
