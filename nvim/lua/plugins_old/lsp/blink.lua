local blink = {
  {
    { 'folke/neodev.nvim', opts = {} },
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
    keys = {
      { '<leader>m', '<cmd>Mason<CR>', { silent = true, desc = 'Mason' } },
    },
  },

  -- Autocompletion
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = {
      {
        'giuxtaposition/blink-cmp-copilot',
        'rafamadriz/friendly-snippets',
        'hrsh7th/cmp-nvim-lsp',
      },
    },
    version = 'v0.*',
    opts_extend = {
      'sources.completion.enabled_providers',
      'sources.compat',
      'sources.default',
    },
    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'accept' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<C-p>'] = { 'show', 'select_prev', 'fallback' },
        ['<C-n>'] = { 'show', 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },

      --keymap = {
      --  ['<D-c>'] = { 'show' },
      --  ['<S-CR>'] = { 'cancel' },
      --  ['<CR>'] = { 'select_and_accept', 'fallback' },
      --  ['<Tab>'] = { 'select_next', 'fallback' },
      --  ['<S-Tab>'] = { 'select_prev', 'fallback' },
      --  ['<Down>'] = { 'select_next', 'fallback' },
      --  ['<Up>'] = { 'select_prev', 'fallback' },
      --  ['<PageDown>'] = { 'scroll_documentation_down' },
      --  ['<PageUp>'] = { 'scroll_documentation_up' },
      --},

      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = false,
          default_brackets = { '(', ')' },
          override_brackets_for_filetypes = {},
          -- Overrides the default blocked filetypes
          force_allow_filetypes = {},
          blocked_filetypes = {},
          -- Synchronously use the kind of the item to determine if brackets should be added
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
          },
          -- Asynchronously use semantic token to determine if brackets should be added
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {},
            -- How long to wait for semantic tokens to return before assuming no brackets should be added
            timeout_ms = 400,
          },
        },
      },

      trigger = {
        completion = {
          -- 'prefix' will fuzzy match on the text before the cursor
          -- 'full' will fuzzy match on the text before *and* after the cursor
          -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
          keyword_range = 'prefix',
          -- regex used to get the text when fuzzy matching
          -- changing this may break some sources, so please report if you run into issues
          -- todo: shouldnt this also affect the accept command? should this also be per language?
          keyword_regex = '[%w_\\-]',
          -- after matching with keyword_regex, any characters matching this regex at the prefix will be excluded
          exclude_from_prefix_regex = '[\\-]',
          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (*cough* tsserver *cough*) return characters that would essentially
          -- always show the window. We block these by default
          blocked_trigger_characters = { ' ', '\n', '\t' },
          -- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
          -- list of additional trigger characters that won't trigger the completion window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_blocked_trigger_characters = { "'", '"' },
          -- when false, will not show the completion window when in a snippet
          show_in_snippet = false,
        },

        signature_help = {
          enabled = true,
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          -- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
      },

      fuzzy = {
        -- frencency tracks the most recently/frequently used items and boosts the score of the item
        use_frecency = true,
        -- proximity bonus boosts the score of items with a value in the buffer
        use_proximity = true,
        max_items = 200,
        -- controls which sorts to use and in which order, these three are currently the only allowed options
        sorts = { 'label', 'kind', 'score' },

        prebuiltBinaries = {
          -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
          -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
          download = true,
          -- When downloading a prebuilt binary force the downloader to resolve this version. If this is uset
          -- then the downloader will attempt to infer the version from the checked out git tag (if any).
          --
          -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
          forceVersion = nil,
        },
      },

      menu = {
        border = vim.g.borderStyle,
        draw = {
          columns = {
            { 'label', 'label_description', 'kind_icon', gap = 1 },
          },
          components = {
            label = { width = { max = 30 } }, -- more space for doc-win
            label_description = { width = { max = 20 } },
            kind_icon = {
              text = function(ctx)
                -- detect emmet-ls
                local source, client = ctx.item.source_id, ctx.item.client_id
                local lspName = client and vim.lsp.get_client_by_id(client).name
                if lspName == 'emmet_language_server' then
                  source = 'emmet'
                end

                -- use source-specific icons, and `kind_icon` only for items from LSPs
                local sourceIcons = { snippets = '󰩫', buffer = '󰦨', emmet = '', path = '' }
                return sourceIcons[source] or ctx.kind_icon
              end,
            },
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      sources = {
        completion = {
          enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        },
        providers = {
          lsp = {
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',

            --- *All* of the providers have the following options available
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information
            enabled = true, -- whether or not to enable the provider
            transform_items = nil, -- function to transform the items before they're returned
            should_show_items = true, -- whether or not to show the items
            max_items = nil, -- maximum number of items to return
            min_keyword_length = 0, -- minimum number of characters to trigger the provider
            fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
            score_offset = 0, -- boost/penalize the score of the items
            override = nil, -- override the source's functions
          },
          path = {
            name = 'Path',
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
              end,
              show_hidden_files_by_default = false,
            },
          },
          snippets = {
            name = 'Snippets',
            module = 'blink.cmp.sources.snippets',
            score_offset = -3,
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath('config') .. '/snippets' },
              global_snippets = { 'all' },
              extended_filetypes = {},
              ignored_filetypes = {},
            },

            --- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
            -- enabled = function(ctx) return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter end,
          },
          buffer = {
            name = 'Buffer',
            module = 'blink.cmp.sources.buffer',
            fallback_for = { 'lsp' },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
          },
        },
      },

      windows = {
        autocomplete = {
          min_width = vim.o.pumwidth,
          max_height = 20,
          border = 'none',
          winblend = vim.o.pumblend,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          -- keep the cursor X lines away from the top/bottom of the window
          scrolloff = 2,
          -- which directions to show the window,
          -- falling back to the next direction when there's not enough space
          direction_priority = { 's', 'n' },
          -- Controls whether the completion window will automatically show when typing
          auto_show = true,
          -- Controls how the completion items are selected
          -- 'preselect' will automatically select the first item in the completion list
          -- 'manual' will not select any item by default
          -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
          selection = 'auto_insert',
          -- Controls how the completion items are rendered on the popup window
          -- 'simple' will render the item's kind icon the left alongside the label
          -- 'reversed' will render the label on the left and the kind icon + name on the right
          -- 'minimal' will render the label on the left and the kind name on the right
          -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          },
          -- Controls the cycling behavior when reaching the beginning or end of the completion list.
          cycle = {
            -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
            from_bottom = true,
            -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
            from_top = true,
          },
        },
        documentation = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = 'padded',
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
          -- which directions to show the documentation window,
          -- for each of the possible autocomplete window directions,
          -- falling back to the next direction when there's not enough space
          direction_priority = {
            autocomplete_north = { 'e', 'w', 'n', 's' },
            autocomplete_south = { 'e', 'w', 's', 'n' },
          },
          -- Controls whether the documentation window will automatically show when selecting a completion item
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
        },
        signature_help = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = 'padded',
          winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        },
        ghost_text = {
          enabled = false,
        },
      },

      highlight = {
        ns = vim.api.nvim_create_namespace('blink_cmp'),
        use_nvim_cmp_as_default = true,
      },

      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',

      -- don't show completions or signature help for these filetypes. Keymaps are also disabled.
      blocked_filetypes = {},

      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
  },
  {
    'giuxtaposition/blink-cmp-copilot',
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'SmiteshP/nvim-navic' },
      { 'saghen/blink.cmp' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      local map = require('utils').map
      local lspbuf = vim.lsp.buf

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        -- INFO: Turned off in favor of glance. See plugins/glance.lua
        -- map("n", "gr", builtin.lsp_references, { buffer = bufnr, remap = false, desc = "lsp references" })
        -- map("n", "gi", builtin.lsp_implementations, { buffer = bufnr, remap = false, desc = "implementations" })
        -- map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, remap = false, desc = "type definition" })
        -- map("n", "gd", lspbuf.definition, { buffer = bufnr, remap = false, desc = "definition" })

        map('n', 'ga', lspbuf.code_action, { buffer = bufnr, remap = false, desc = 'code actions' })
        map('n', 'gD', lspbuf.declaration, { buffer = bufnr, remap = false, desc = 'declaration' })

        map('n', 'gn', vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = 'next diagnostic' })
        map('n', 'gp', vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = 'previous diagnostic' })

        map('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = 'buf rename' })
        map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = 'buffer hover' })

        if client.server_capabilities['documentSymbolProvider'] then
          require('nvim-navic').attach(client, bufnr)
          require('nvim-navbuddy').attach(client, bufnr)
        end
      end

      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          silent = true,
          border = 'rounded',
        }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics,
          { virtual_text = false }
        ),
      }

      local has_blink, blink = pcall(require, 'blink')
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {}
      )

      lsp_zero.extend_lspconfig({
        sign_text = {
          error = '',
          warn = '',
          hint = '',
          info = '',
        },
        handlers = handlers,
        lsp_attach = lsp_attach,
        float_border = 'rounded',

        capabilities = capabilities,
      })

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')

      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'clangd',
          'cssls',
          'docker_compose_language_service',
          'dockerls',
          'emmet_ls',
          'eslint',
          'gopls',
          'graphql',
          'helm_ls',
          'html',
          'jsonls',
          'lua_ls',
          'pyright',
          'ruff',
          'rust_analyzer',
          'sqlls',
          'tailwindcss',
          'terraformls',
          'vimls',
          'vtsls',
          'yamlls',
        },

        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          ['yamlls'] = function()
            require('lspconfig').yamlls.setup({
              settings = {
                yaml = {
                  schemas = { kubernetes = 'globPattern' },
                },
              },
            })
          end,

          ['gopls'] = function()
            require('lspconfig').gopls.setup({
              settings = require('plugins.lsp.servers.gopls').settings,
              on_attach = require('plugins.lsp.servers.gopls').on_attach,
            })
          end,

          ['lua_ls'] = function()
            require('neodev').setup({})
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                  },
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                  },
                },
              },
            })
          end,

          ['tailwindcss'] = function()
            require('lspconfig').tailwindcss.setup({
              capabilities = require('plugins.lsp.servers.tailwindcss').capabilities,
              filetypes = require('plugins.lsp.servers.tailwindcss').filetypes,
              init_options = require('plugins.lsp.servers.tailwindcss').init_options,
              on_attach = require('plugins.lsp.servers.tailwindcss').on_attach,
              settings = require('plugins.lsp.servers.tailwindcss').settings,
            })
          end,

          ['cssls'] = function()
            require('lspconfig').cssls.setup({
              on_attach = require('plugins.lsp.servers.cssls').on_attach,
              settings = require('plugins.lsp.servers.cssls').settings,
            })
          end,

          ['eslint'] = function()
            require('lspconfig').eslint.setup({
              on_attach = require('plugins.lsp.servers.eslint').on_attach,
              settings = require('plugins.lsp.servers.eslint').settings,
            })
          end,

          ['jsonls'] = function()
            require('lspconfig').jsonls.setup({
              settings = require('plugins.lsp.servers.jsonls').settings,
            })
          end,

          ['vuels'] = function()
            require('lspconfig').vuels.setup({
              filetypes = require('plugins.lsp.servers.vuels').filetypes,
              init_options = require('plugins.lsp.servers.vuels').init_options,
              on_attach = require('plugins.lsp.servers.vuels').on_attach,
              settings = require('plugins.lsp.servers.vuels').settings,
            })
          end,
        },
      })

      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
