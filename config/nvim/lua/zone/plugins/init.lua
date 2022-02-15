local present, zone_packer = pcall(require, 'zone.packer')

if not present then
  return false
end

local packer = zone_packer.packer
local use = packer.use

local config = require('zone.config')

return packer.startup(function()
  use({
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'nathom/filetype.nvim',
    'nvim-lua/plenary.nvim',
  })

  -- initialize theme plugins
  require('zone.theme.plugins').init(use, config)

  use({
    'rcarriga/nvim-notify',
    config = function()
      require('zone.plugins.notify')
    end,
    after = config.theme,
  })

  -- theme stuff
  use({ -- statusline
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('zone.plugins.galaxyline')
    end,
    after = config.theme,
  })

  -- file explorer
  use({
    'kyazdani42/nvim-tree.lua',
    commit = '3f4ed9b6c2598ab8304186486a05ae7a328b8d49',
    config = function()
      require('zone.plugins.nvim-tree')
    end,
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
  })

  use({
    'MunifTanjim/nui.nvim',
  })

  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('zone.lsp')
    end,
    requires = {
      { 'b0o/SchemaStore.nvim' },
      { 'williamboman/nvim-lsp-installer' },
      { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('zone.lsp.providers.null_ls')
        end,
        after = 'nvim-lspconfig',
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function()
          require('zone.plugins.lsp-signature')
        end,
        after = 'nvim-lspconfig',
      },
    },
  })

  -- autocompletion
  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require('zone.plugins.nvim-cmp')
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('zone.plugins.luasnip')
        end,
        requires = {
          'rafamadriz/friendly-snippets',
        },
      },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      {
        'windwp/nvim-autopairs',
        config = function()
          require('zone.plugins.auto-pairs')
        end,
        after = 'nvim-cmp',
      },
    },
    event = 'InsertEnter',
  })

  -- git commands
  use({
    'tpope/vim-fugitive',
    opt = true,
    cmd = 'Git',
  })

  -- git column signs
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    opt = true,
    event = 'BufRead',
    config = function()
      require('zone.plugins.gitsigns')
    end,
  })

  -- floating terminal
  use({
    'voldikss/vim-floaterm',
    opt = true,
    event = 'BufWinEnter',
    config = function()
      require('zone.plugins.terminal')
    end,
  })

  -- file navigation
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
      require('zone.plugins.telescope.mappings').init()
      require('zone.plugins.telescope')
    end,
    event = 'BufWinEnter',
  })

  -- session/project management
  use({
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require('zone.plugins.alpha')
    end
  })

  use({
    'rmagatti/auto-session',
    config = function()
      require('zone.plugins.auto-session')
    end,
  })

  -- lang/syntax stuff
  use({
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = ':TSUpdate',
    config = function()
      require('zone.plugins.treesitter')
    end,
  })

  -- comments and stuff
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('zone.plugins.comments')
    end,
    event = 'BufWinEnter',
  })

  -- todo highlights
  use({
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('zone.plugins.todo-comments')
    end,
    event = 'BufWinEnter',
  })
  -- colorized hex codes
  use({
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = { 'ColorizerToggle' },
    config = function()
      require('zone.plugins.colorizer')
    end,
  })

  if zone_packer.first_install then
    packer.sync()
  end
end)
