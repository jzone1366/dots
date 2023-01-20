return {
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('zone.plugins.mason-lspconfig.config')
  end,
  dependencies = {
    'stevearc/aerial.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-lua/lsp-status.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'jose-elias-alvarez/null-ls.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'b0o/SchemaStore.nvim',
  },
  event = 'BufEnter',
}
