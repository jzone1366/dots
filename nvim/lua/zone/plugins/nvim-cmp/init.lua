return {
  'hrsh7th/nvim-cmp',
    config = function()
      require('zone.plugins.nvim-cmp.config')
    end,
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'windwp/nvim-autopairs',
    },
    event = 'InsertEnter',
}
