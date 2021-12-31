local M = {}

M.supported_themes = {
  'gruvbox',
  'kanagawa',
  'nightfox',
  'onedark',
  'rose-pine',
  'tokyonight',
}

function M.init(use, config)
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
      vim.cmd('color nightfox')
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
      vim.g.rose_pine_variant = 'moon'
      vim.cmd('colorscheme rose-pine')
    end,
    disable = config.theme ~= 'rose-pine',
  })

  use({ -- color scheme
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_sidebars = { 'qf' }
      vim.cmd('color tokyonight')
    end,
    disable = config.theme ~= 'tokyonight',
  })
end

return M
