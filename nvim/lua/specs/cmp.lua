return {
  'hrsh7th/nvim-cmp',
  enabled = true,
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'roobert/tailwindcss-colorizer-cmp.nvim',
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local vscodesnippets = require('luasnip.loaders.from_vscode')
    local tailwindcss_cmp = require('tailwindcss-colorizer-cmp')
    local icons = require('theme').icons

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }), -- end of mapping section
      -- Managing Sources for completions
      sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'copilot', priority = 11, max_item_count = 3 },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s %s', icons.vscode[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind

          -- Then apply tailwindcss-colorizer-cmp formatter
          return tailwindcss_cmp.formatter(entry, vim_item)
        end,
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
        { name = 'buffer' },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })

    -- tailwindcss_cmp
    tailwindcss_cmp.setup({
      color_square_width = 2,
    })

    --  VS Code like snippets
    vscodesnippets.lazy_load()
  end,
}
