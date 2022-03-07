local M = {}

M.supported_themes = {
  'ayu',
  'gruvbox',
  'kanagawa',
  'nightfox',
  'onedark',
  'paperzone',
  'rose-pine',
  'tokyonight',
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

  -- @TODO update with correct github when pushed up.
  use({
    '~/dev/papercolor/lua/paperzone',
    as = 'paperzone',
    config = function()
      vim.cmd('color paperzone')
    end,
    disable = config.theme ~= 'paperzone',
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

  use({ -- color scheme
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = 'day'
      vim.g.tokyonight_sidebars = { 'qf' }
      vim.cmd('color tokyonight')
    end,
    disable = config.theme ~= 'tokyonight',
  })
end

return M
