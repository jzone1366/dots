-- ┌────────────┐
-- │ Completion │
-- └────────────┘

local add, now_if_args, later = vim.pack.add, Config.now_if_args, Config.later

local has_words_before = function()
  if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

-- blink.cmp loads here, before 44_lsp.lua, which reads its LSP capabilities.
now_if_args(function()
  add({
    'https://github.com/saghen/blink.cmp',
    'https://github.com/saghen/blink.compat',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/xzbdmw/colorful-menu.nvim',
  })

  require('blink.cmp').setup({
    --keymap = { preset = 'default' },
    fuzzy = { implementation = 'lua' },
    -- Set my own, and get rid of the ones I don't use
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-c>'] = { 'hide' },

      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if not has_words_before() then
            return
          end

          if cmp.is_menu_visible() then
            return cmp.select_next()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },

    completion = {
      accept = {
        -- Experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = 'rounded',
        draw = {
          padding = 1,
          gap = 2,
          columns = { { 'kind_icon' }, { 'label', 'kind', gap = 2 } },
          components = {
            label = {
              width = { fill = true },
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
            label_description = { width = { fill = true } },
            kind_icon = {
              text = function(ctx)
                local MiniIcons = require('mini.icons')
                local source = ctx.item.source_name
                local label = ctx.item.label
                local icon = source == 'LSP' and MiniIcons.get('lsp', ctx.kind)
                  or source == 'copilot' and MiniIcons.get('filetype', source)
                  or source == 'Path' and (label:match('%.[^/]+$') and MiniIcons.get('file', label) or MiniIcons.get(
                    'directory',
                    ctx.item.label
                  ))
                  or ctx.kind_icon

                return icon .. ' '
              end,
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },

    cmdline = { enabled = false },

    sources = {
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          async = true,
          score_offset = 100, -- Copilot higher in list; lower if too aggressive
        },
        -- Table/column/keyword completion from the connected database.
        -- Only active in buffers with a connection (grip's query pad sets b:db).
        dadbod_grip = {
          name = 'Grip SQL',
          module = 'dadbod-grip.completion.blink',
        },
      },

      per_filetype = {
        sql = { 'dadbod_grip', inherit_defaults = true },
      },

      default = { 'lsp', 'path', 'buffer', 'copilot' },
    },
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
  add({ 'https://github.com/rafamadriz/friendly-snippets' })
end)
