local fn, lsp = vim.fn, vim.lsp

-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'mini.icons', words = { 'MiniIcons' } },
        { path = 'mini.pick', words = { 'MiniPick' } },
      },
    },
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = 'modern',
        multilines = true,
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'b0o/schemastore.nvim' },

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('swift-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', '<cmd>Pick lsp scope="definition"<CR>', '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', '<cmd>Pick lsp scope="declaration"<CR>', '[G]oto [D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', '<cmd>Pick lsp scope="references"<CR>', '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', '<cmd>Pick lsp scope="implementation"<CR>', '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', '<cmd>Pick lsp scope="type_definition"<CR>', 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', '<cmd>Pick lsp scope="document_symbol"<CR>', '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', '<cmd>Pick lsp scope="workspace_symbol"<CR>', '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('swift-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('swift-lsp-detach', { clear = true }),
              callback = function(event2)
                lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'swift-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end

          if client and client.supports_method(lsp.protocol.Methods.textDocument_documentSymbol) then
            require('nvim-navic').attach(client, event.buf)
            require('nvim-navbuddy').attach(client, event.buf)
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.have_nerd_font then
      --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      --   local diagnostic_signs = {}
      --   for type, icon in pairs(signs) do
      --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
      --   end
      --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
      -- end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      --capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local runtime_path = vim.split(package.path, ';')
      local servers = {
        gopls = {
          settings = require('specs.lsp.servers.gopls').settings,
          on_attach = require('specs.lsp.servers.gopls').on_attach,
        },
        solargraph = {},
        yamlls = {
          settings = {
            yaml = {
              format = { enable = true },
              validate = true,
              hover = true,
              completion = true,
              schemas = require('schemastore').json.schemas(),
              customTags = {
                '!reference sequence', -- necessary for gitlab-ci.yaml files
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                path = runtime_path,
                version = 'LuaJIT',
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
              hint = {
                enable = true,
                arrayIndex = 'Disable', -- "Enable", "Auto", "Disable"
                await = true,
                paramName = 'Disable', -- "All", "Literal", "Disable"
                paramType = true,
                semicolon = 'Disable', -- "All", "SameLine", "Disable"
                setType = true,
              },
              diagnostics = {
                globals = {
                  'packer_plugins',
                  'Color',
                  'Group',
                  'after_each',
                  'before_each',
                  'c',
                  'cmap',
                  'cnoremap',
                  'config',
                  'describe',
                  'g',
                  'hs',
                  'imap',
                  'import',
                  'inoremap',
                  'it',
                  'lmap',
                  'lnoremap',
                  'map',
                  'swift',
                  'nmap',
                  'nnoremap',
                  'noremap',
                  'omap',
                  'onoremap',
                  's',
                  'smap',
                  'snoremap',
                  'spoon',
                  'tmap',
                  'tnoremap',
                  'vim',
                  'vmap',
                  'vnoremap',
                  'watchers',
                  'xmap',
                  'xnoremap',
                },
                unusedLocalExclude = { '_*' },
              },
              completion = {
                keywordSnippet = 'Replace',
                workspaceWord = true,
                callSnippet = 'Both',
              },
              misc = {
                parameters = {
                  '--log-level=trace',
                },
              },
              workspace = {
                ignoreSubmodules = true,
                library = { fn.expand('$VIMRUNTIME/lua'), plugins, plenary, wezterm },
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
          handlers = {
            -- always go to the first definition
            ['textDocument/definition'] = function(err, result, ...)
              if vim.islist(result) or type(result) == 'table' then
                result = result[1]
              end
              lsp.handlers['textDocument/definition'](err, result, ...)
            end,
          },
        },

        tailwindcss = {
          capabilities = require('specs.lsp.servers.tailwindcss').capabilities,
          filetypes = require('specs.lsp.servers.tailwindcss').filetypes,
          init_options = require('specs.lsp.servers.tailwindcss').init_options,
          on_attach = require('specs.lsp.servers.tailwindcss').on_attach,
          settings = require('specs.lsp.servers.tailwindcss').settings,
        },

        cssls = {
          on_attach = require('specs.lsp.servers.cssls').on_attach,
          settings = require('specs.lsp.servers.cssls').settings,
        },

        eslint = {
          on_attach = require('specs.lsp.servers.eslint').on_attach,
          settings = require('specs.lsp.servers.eslint').settings,
        },

        jsonls = require('specs.lsp.servers.jsonls').settings,

        pyright = {
          single_file_support = false,
          settings = {
            python = {
              format = false,
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        vuels = {
          filetypes = require('specs.lsp.servers.vuels').filetypes,
          init_options = require('specs.lsp.servers.vuels').init_options,
          on_attach = require('specs.lsp.servers.vuels').on_attach,
          settings = require('specs.lsp.servers.vuels').settings,
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'vtsls',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    'wochap/lsp-lens.nvim',
    event = { 'LazyFile', 'VeryLazy' },
    opts = {
      enable = true,
      include_declaration = false,
      sections = {
        definition = false,
        references = function(count)
          return '  ' .. count .. ' '
        end,
        implements = false,
        git_authors = false,
      },
    },
    config = function(_, opts)
      require('lsp-lens').setup(opts)

      -- override lsp_lens augroup, update its event list
      local lens = require('lsp-lens.lens-util')
      local augroup = vim.api.nvim_create_augroup('lsp_lens', { clear = true })
      vim.api.nvim_create_autocmd({ 'LspAttach', 'InsertLeave', 'CursorHold', 'BufEnter' }, {
        group = augroup,
        callback = function(...)
          local mode = vim.api.nvim_get_mode().mode
          -- Only run if not in insert mode
          if mode ~= 'i' then
            lens.procedure(...)
          end
        end,
      })
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    opts = {},
    config = function(_, opts)
      local hl = require('actions-preview.highlight')
      opts.highlight_command = {
        hl.delta('delta --dark --paging=never'),
      }
      require('actions-preview').setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
