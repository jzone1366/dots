return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'awk',
                'bash',
                'c',
                'cmake',
                'cpp',
                'css',
                'csv',
                'diff',
                'dockerfile',
                'dot',
                'fish',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'go',
                'gomod',
                'gowork',
                'gosum',
                'graphql',
                'html',
                'http',
                'java',
                'javascript',
                'jsdoc',
                'json',
                'json5',
                'jsonc',
                'julia',
                'latex',
                'lua',
                'luap',
                'make',
                'markdown',
                'markdown_inline',
                'nix',
                'norg',
                'perl',
                'php',
                'prisma',
                'proto',
                'pug',
                'python',
                'r',
                'regex',
                'rust',
                'scss',
                'ssh_config',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'xml',
                'yaml',
            },                                  -- one of "all", or a list of languages
            sync_install = false,               -- install languages synchronously (only applied to `ensure_installed`)
            ignore_install = { 'haskell', 'phpdoc' }, -- list of parsers to ignore installing
            highlight = { enable = true, },

            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = '<leader>gnn',
                    node_incremental = '<leader>gnr',
                    scope_incremental = '<leader>gne',
                    node_decremental = '<leader>gnt',
                },
            },

            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']]'] = '@function.outer',
                        [']m'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']['] = '@function.outer',
                        [']M'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[['] = '@function.outer',
                        ['[m'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[]'] = '@function.outer',
                        ['[M'] = '@class.outer',
                    },
                },
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['~'] = '@parameter.inner',
                    },
                },
            },

            textsubjects = {
                enable = true,
                prev_selection = '<BS>',
                keymaps = {
                    ['<CR>'] = 'textsubjects-smart', -- works in visual mode
                },
            },

            indent = { enable = true, },
            autopairs = { enable = true }
        })
    end,
    dependencies = {
        'hiphish/rainbow-delimiters.nvim',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'RRethy/nvim-treesitter-textsubjects',
    },
}
