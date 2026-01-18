-- LSP Configuration for mini.deps
local fn, lsp = vim.fn, vim.lsp

return function()
  -- LspAttach autocmd for keymappings and features
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('swift-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('gd', '<cmd>Pick lsp scope="definition"<CR>', '[G]oto [D]efinition')
      map('gD', '<cmd>Pick lsp scope="declaration"<CR>', '[G]oto [D]eclaration')
      map('gr', '<cmd>Pick lsp scope="references"<CR>', '[G]oto [R]eferences')
      map('gI', '<cmd>Pick lsp scope="implementation"<CR>', '[G]oto [I]mplementation')
      map('<leader>D', '<cmd>Pick lsp scope="type_definition"<CR>', 'Type [D]efinition')
      map('<leader>ds', '<cmd>Pick lsp scope="document_symbol"<CR>', '[D]ocument [S]ymbols')
      map('<leader>ws', '<cmd>Pick lsp scope="workspace_symbol"<CR>', '[W]orkspace [S]ymbols')
      map('<leader>rn', lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

      local client = lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(lsp.protocol.Methods.textDocument_documentHighlight) then
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

      if client and client:supports_method(lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
          lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, '[T]oggle Inlay [H]ints')
      end

      if client and client:supports_method(lsp.protocol.Methods.textDocument_documentSymbol) then
        require('nvim-navic').attach(client, event.buf)
        require('nvim-navbuddy').attach(client, event.buf)
      end
    end,
  })

  -- Get blink.cmp capabilities
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

  -- Server configurations
  local runtime_path = vim.split(package.path, ';')
  local servers = {
    gopls = {
      settings = require('specs.lsp.servers.gopls').settings,
      on_attach = require('specs.lsp.servers.gopls').on_attach,
    },
    yamlls = {
      settings = {
        yaml = {
          format = { enable = true },
          validate = true,
          hover = true,
          completion = true,
          schemas = require('schemastore').json.schemas(),
          customTags = {
            '!reference sequence',
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
            arrayIndex = 'Disable',
            await = true,
            paramName = 'Disable',
            paramType = true,
            semicolon = 'Disable',
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
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      handlers = {
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

  -- Ensure tools are installed
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua',
    'vtsls',
  })
  require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

  -- Setup LSP servers
  require('mason-lspconfig').setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end,
    },
  })
end
