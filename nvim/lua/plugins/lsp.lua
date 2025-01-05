local fn, lsp = vim.fn, vim.lsp
local SETTINGS = require('swift.settings')

return {
  {
    'yioneko/nvim-vtsls',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    dependencies = { 'nvim-lspconfig' },
    config = true,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = 'minimal',
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    cond = false,
    opts = {
      progress = {
        display = {
          done_icon = SETTINGS.icons.lsp.ok,
        },
      },
      notification = {
        view = {
          group_separator = '─────', -- digraph `hh`
        },
        window = {
          winblend = 0,
        },
      },
    },
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

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'youssef-lr/lsp-overloads.nvim' },
      { 'b0o/schemastore.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'SmiteshP/nvim-navic' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      local map = require('utils').map
      local lspbuf = lsp.buf

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        -- INFO: Turned off in favor of glance. See plugins/glance.lua
        -- map("n", "gr", builtin.lsp_references, { buffer = bufnr, remap = false, desc = "lsp references" })
        -- map("n", "gi", builtin.lsp_implementations, { buffer = bufnr, remap = false, desc = "implementations" })
        -- map("n", "gt", lsp.buf.type_definition, { buffer = bufnr, remap = false, desc = "type definition" })
        -- map("n", "gd", lspbuf.definition, { buffer = bufnr, remap = false, desc = "definition" })

        map('n', 'ga', lspbuf.code_action, { buffer = bufnr, remap = false, desc = 'code actions' })
        map('n', 'gD', lspbuf.declaration, { buffer = bufnr, remap = false, desc = 'declaration' })

        map('n', 'gn', vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = 'next diagnostic' })
        map('n', 'gp', vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = 'previous diagnostic' })

        map('n', '<Leader>rn', lsp.buf.rename, { buffer = bufnr, remap = false, desc = 'buf rename' })
        map('n', 'K', lsp.buf.hover, { buffer = bufnr, remap = false, desc = 'buffer hover' })

        if client.server_capabilities['documentSymbolProvider'] then
          require('nvim-navic').attach(client, bufnr)
          require('nvim-navbuddy').attach(client, bufnr)
        end
      end

      local handlers = {
        ['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
          silent = true,
          border = 'rounded',
        }),
        ['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'rounded' }),
        ['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }),
      }

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
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
            })
          end,

          ['gopls'] = function()
            require('lspconfig').gopls.setup({
              settings = require('swift.servers.gopls').settings,
              on_attach = require('swift.servers.gopls').on_attach,
            })
          end,

          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup({
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
            })
          end,

          ['tailwindcss'] = function()
            require('lspconfig').tailwindcss.setup({
              capabilities = require('swift.servers.tailwindcss').capabilities,
              filetypes = require('swift.servers.tailwindcss').filetypes,
              init_options = require('swift.servers.tailwindcss').init_options,
              on_attach = require('swift.servers.tailwindcss').on_attach,
              settings = require('swift.servers.tailwindcss').settings,
            })
          end,

          ['cssls'] = function()
            require('lspconfig').cssls.setup({
              on_attach = require('swift.servers.cssls').on_attach,
              settings = require('swift.servers.cssls').settings,
            })
          end,

          ['eslint'] = function()
            require('lspconfig').eslint.setup({
              on_attach = require('swift.servers.eslint').on_attach,
              settings = require('swift.servers.eslint').settings,
            })
          end,

          ['jsonls'] = function()
            require('lspconfig').jsonls.setup({
              settings = require('swift.servers.jsonls').settings,
            })
          end,

          ['pyright'] = function()
            require('lspconfig').pyright.setup({
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
            })
          end,

          ['vuels'] = function()
            require('lspconfig').vuels.setup({
              filetypes = require('swift.servers.vuels').filetypes,
              init_options = require('swift.servers.vuels').init_options,
              on_attach = require('swift.servers.vuels').on_attach,
              settings = require('swift.servers.vuels').settings,
            })
          end,
        },
      })

      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
