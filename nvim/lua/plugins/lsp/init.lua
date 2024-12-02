return {
    {
        { "folke/neodev.nvim", opts = {} }
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
        }
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp', -- Go back to this if he updates
        --"iguanacucumber/magazine.nvim",
        --name = "nvim-cmp", -- Otherwise highlighting gets messed up
        event = 'InsertEnter',
        dependencies = {
            'onsails/lspkind-nvim',
            'petertriho/cmp-git',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip',
                dependencies = 'rafamadriz/friendly-snippets',
                build = 'make install_jsregexp',
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
                end,
            },
            {
                'David-Kunz/cmp-npm',
                config = function()
                    require('plugins.lsp.cmp-npm')
                end,
            },
            {
                'zbirenbaum/copilot-cmp',
                config = function()
                    require('copilot_cmp').setup()
                end,
            },
        },
        config = function()
            require('plugins.lsp.cmp')
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'SmiteshP/nvim-navic' }
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            local map = require("utils").map
            local builtin = require('telescope.builtin')
            local lspbuf = vim.lsp.buf

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols,
                    { buffer = bufnr, remap = false, desc = "workspace symbols" })

                -- INFO: Turned off in favor of glance. See plugins/glance.lua
                -- map("n", "gr", builtin.lsp_references, { buffer = bufnr, remap = false, desc = "lsp references" })
                -- map("n", "gi", builtin.lsp_implementations, { buffer = bufnr, remap = false, desc = "implementations" })
                -- map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, remap = false, desc = "type definition" })
                -- map("n", "gd", lspbuf.definition, { buffer = bufnr, remap = false, desc = "definition" })

                map("n", "<leader>o", builtin.lsp_document_symbols,
                    { buffer = bufnr, remap = false, desc = "document symbols" })
                map("n", "ga", lspbuf.code_action, { buffer = bufnr, remap = false, desc = "code actions" })
                map("n", "gD", lspbuf.declaration, { buffer = bufnr, remap = false, desc = "declaration" })

                map("n", "gn", vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = "next diagnostic" })
                map("n", "gp", vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = "previous diagnostic" })

                map("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "buf rename" })
                map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "buffer hover" })

                if client.server_capabilities['documentSymbolProvider'] then
                    require('nvim-navic').attach(client, bufnr)
                    require('nvim-navbuddy').attach(client, bufnr)
                end
            end

            local handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                    silent = true,
                    border = "rounded",
                }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
                    { border = "rounded" }),
                ['textDocument/publishDiagnostics'] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics,
                    { virtual_text = true }
                ),
            }

            lsp_zero.extend_lspconfig({
                sign_text = {
                    error = '',
                    warn = '',
                    hint = '',
                    info = ''
                },
                handlers = handlers,
                lsp_attach = lsp_attach,
                float_border = 'rounded',
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

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
                        require('lspconfig')[server_name].setup({
                        })
                    end,

                    ['yamlls'] = function()
                        require('lspconfig').yamlls.setup({
                            settings = {
                                yaml = {
                                    schemas = { kubernetes = "globPattern" },
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
                        require("neodev").setup({})
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = 'LuaJIT',
                                        path = runtime_path,
                                    },
                                    diagnostics = {
                                        globals = { 'vim' }
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    }
                                }
                            }
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
                }
            })
        end
    }
}
