local theme = require('theme')
local icons = theme.icons

return {
  'saghen/blink.cmp',
  enabled = false,
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '*',
  dependencies = {
    'fang2hou/blink-copilot',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    ---@module  'blink.cmp'
    ---@type blink.cmp.Config
    require('blink.cmp').setup({
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },

        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 5,
            async = true,
            opts = {
              max_completions = 3,
              max_attempts = 4,
            },
          },
          snippets = {
            min_keyword_length = 2,
            score_offset = 4,
          },
          lsp = {
            min_keyword_length = 3,
            score_offset = 3,
          },
          path = {
            min_keyword_length = 3,
            score_offset = 2,
          },
          buffer = {
            min_keyword_length = 5,
            score_offset = 1,
          },
        },
      },

      completion = {
        list = {
          max_items = 10,
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
            auto_insert = function(ctx)
              return ctx.mode == 'cmdline'
            end,
          },
        },
        menu = {
          auto_show = true,
          border = theme.border_style,
          --draw = {
          --  columns = {
          --    { 'kind_icon', 'label', gap = 1 },
          --    { 'source_name' },
          --  },
          --  components = {
          --    kind_icon = {
          --      text = function(ctx)
          --        return vim.api.nvim_get_mode().mode == 'c' and '' or ctx.kind_icon
          --      end,
          --    },
          --    source_name = {
          --      width = { max = 30 },
          --      text = function(ctx)
          --        return icons.vscode[ctx.source_name]
          --      end,
          --      highlight = 'BlinkCmpSource',
          --    },
          --  },
          --  treesitter = { 'lsp' },
          --},
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            border = theme.border_style,
          },
        },
        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
        accept = { auto_brackets = { enabled = true } },
      },
      --fuzzy = {
      --  use_typo_resistance = false,
      --},
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-e>'] = { 'cancel' },
        cmdline = {
          ['<cr>'] = {
            function(cmp)
              return cmp.accept({
                callback = function()
                  vim.api.nvim_feedkeys('\n', 'n', true)
                end,
              })
            end,
            'fallback',
          },
          ['<Tab>'] = { 'select_next' },
          ['<S-Tab>'] = { 'select_prev' },
          ['<C-e>'] = { 'cancel' },
        },
      },
      appearance = {
        kind_icons = icons.kind,
      },
      signature = {
        enabled = true,
        window = {
          border = theme.border_style,
        },
      },
    })
  end,
}
