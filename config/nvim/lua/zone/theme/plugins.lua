local M = {}

M.supported_themes = {
  'gruvbox',
  'kanagawa',
  'nightfox',
  'onedark',
  'rose-pine',
  'tokyonight',
}

function M.init(use)
  use({
    'ellisonleao/gruvbox.nvim',
    as = 'gruvbox',
    requires = { 'rktjmp/lush.nvim' },
    config = function()
      vim.o.background = 'dark'
      vim.cmd('color gruvbox')
    end,
  })

  use({
    'rebelot/kanagawa.nvim',
    as = 'kanagawa',
    config = function()
      vim.cmd('colorscheme kanagawa')
    end,
  })

  use({
    'EdenEast/nightfox.nvim',
    as = 'nightfox',
    config = function()
      vim.cmd('color nightfox')
    end,
  })

  use({
    'navarasu/onedark.nvim',
    as = 'onedark',
    config = function()
      vim.cmd('color onedark')
    end,
  })

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.g.rose_pine_variant = 'main'
      vim.cmd('colorscheme rose-pine')
    end,
  })

  use({ -- color scheme
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_sidebars = { 'qf' }
      vim.cmd('color tokyonight')
    end,
  })
end

return M
