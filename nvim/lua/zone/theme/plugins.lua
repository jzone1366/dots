local M = {}

M.theme = 'chalklines'

M.supported_themes = {
  'ayu',
  'chalklines',
  'gruvbox',
  'kanagawa',
  'nightfox',
  'onedark',
  'rose-pine',
  'tokyonight',
}

function M.init(use)
  use {
    'Shatur/neovim-ayu',
    as = 'ayu',
    config = function()
      vim.o.background = 'light'
      vim.cmd 'color ayu-light'
    end,
    disable = M.theme ~= 'ayu',
  }

  use {
    'jzone1366/chalklines.nvim',
    --'~/dev/chalklines.nvim',
    as = 'chalklines',
    config = function()
      vim.o.background = 'dark'
      --vim.o.background = 'light'
      vim.cmd 'colorscheme chalklines'
    end,
    disable = M.theme ~= 'chalklines',
  }

  use {
    'ellisonleao/gruvbox.nvim',
    as = 'gruvbox',
    requires = { 'rktjmp/lush.nvim' },
    config = function()
      vim.o.background = 'dark'
      vim.cmd 'color gruvbox'
    end,
    disable = M.theme ~= 'gruvbox',
  }

  use {
    'rebelot/kanagawa.nvim',
    as = 'kanagawa',
    config = function()
      vim.cmd 'colorscheme kanagawa'
    end,
    disable = M.theme ~= 'kanagawa',
  }

  use {
    'EdenEast/nightfox.nvim',
    as = 'nightfox',
    config = function()
      vim.cmd 'color dayfox'
    end,
    disable = M.theme ~= 'nightfox',
  }

  use {
    'navarasu/onedark.nvim',
    as = 'onedark',
    config = function()
      vim.cmd 'color onedark'
    end,
    disable = M.theme ~= 'onedark',
  }

  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.g.dark_variant = 'main'
      vim.o.background = 'light'
      vim.cmd 'colorscheme rose-pine'
    end,
    disable = M.theme ~= 'rose-pine',
  }

  use {
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      vim.g.tokyonight_style = 'day'
      vim.g.tokyonight_sidebars = { 'qf' }
      vim.cmd 'color tokyonight'
    end,
    disable = M.theme ~= 'tokyonight',
  }
end

return M
