return {
    {
        'echasnovski/mini.align',
        lazy = false,
        version = false,
        config = function()
            require('mini.align').setup()
        end,
    },
    {
        'echasnovski/mini.ai',
        lazy = false,
        version = '*',
        config = function()
            require('mini.ai').setup()
        end,
    },
    {
        'echasnovski/mini.clue',
        lazy = false,
        version = '*',
        config = function()
            local miniclue = require('mini.clue')
            miniclue.setup({
                window = {
                    delay = 0,
                    config = {
                        -- Compute window width automatically
                        width = 'auto',

                        -- Use double-line border
                        border = 'double',
                    },
                },
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })
        end,
    },
}
