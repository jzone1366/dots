local present, zone_packer = pcall(require, 'zone.packer')

if not present then
  return false
end

local packer = zone_packer.packer
local use = packer.use

local theme_plugins = require('zone.theme.plugins')

return packer.startup(function()
  use({
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  })

  -- initialize theme plugins
  theme_plugins.init(use)

  use({
    'rcarriga/nvim-notify',
    config = function()
      require('zone.plugins.notify')
    end,
    after = theme_plugins.theme,
  })

  use({
    'stevearc/aerial.nvim',
    config = function()
      require('zone.plugins.aerial')
    end,
  })

  -- theme stuff
  use({
    'feline-nvim/feline.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'lewis6991/gitsigns.nvim', opt = true },
    },
    config = function()
      require('zone.plugins.feline')
    end,
    after = theme_plugins.theme,
  })

  use({
    'b0o/incline.nvim',
    config = function()
      require('zone.plugins.incline')
    end,
    after = 'feline.nvim',
  })

  -- file explorer
  use({
    'kyazdani42/nvim-tree.lua',
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
    event = 'VimEnter',
  })

  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('zone.lsp')
    end,
    requires = {
      { 'nvim-lua/lsp-status.nvim' },
      { 'b0o/SchemaStore.nvim', module = 'schemastore' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
      { 'jose-elias-alvarez/null-ls.nvim', module = 'null-ls' },
      {
        'ray-x/lsp_signature.nvim',
        config = function()
          require('zone.plugins.lsp-signature')
        end,
        after = 'nvim-lspconfig',
        module = 'lsp_signature',
      },
    },
    event = 'BufWinEnter',
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
    event = 'BufWinEnter',
    config = function()
      require('zone.plugins.gitsigns')
    end,
  })

  -- Git Diff View
  use({
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
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

  use({
    'protex/better-digraphs.nvim',
    opt = true,
    event = 'BufWinEnter',
    after = 'telescope.nvim',
  })

  -- session/project management
  use({
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('zone.plugins.alpha')
    end,
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

  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
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

  -- incrementer/decrementer
  use({
    'zegervdv/nrpattern.nvim',
    requires = {
      'tpope/vim-repeat',
    },
    config = function()
      require('zone.plugins.nrpattern')
    end,
  })

  -- Code Style, Formatting, Linting
  use('editorconfig/editorconfig-vim')

  if zone_packer.first_install then
    packer.sync()
  end
end)
