return {
  {
    'echasnovski/mini.icons',
    version = false,
    config = function()
      require('mini.icons').setup()

      -- Mocks nvim-web-devicons, for plugins that don't support Mini.Icons
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    'echasnovski/mini.cursorword',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mini.cursorword').setup()
    end,
  },
  {
    'echasnovski/mini.extra',
    lazy = false,
    version = false,
    config = function()
      require('mini.extra').setup()
    end,
  },
  {
    'echasnovski/mini.surround',
    event = 'InsertEnter',
    version = false,
    config = function()
      require('mini.surround').setup()
    end,
  },
  {
    'echasnovski/mini.operators',
    event = { 'BufReadPre', 'BufNewFile' },
    version = false,
    config = function()
      require('mini.operators').setup()
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    version = false,
    config = function()
      require('mini.pairs').setup()
    end,
  },
  {
    'echasnovski/mini.align',
    lazy = false,
    version = false,
    config = function()
      require('mini.align').setup({
        mappings = {
          around = 'a',
          inside = 'i',

          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',

          goto_left = 'g[',
          goto_right = 'g]',
        },
        n_lines = 500,
        custom_textobjects = {
          B = require('mini.extra').gen_ai_spec.buffer(),
          D = require('mini.extra').gen_ai_spec.diagnostic(),
          I = require('mini.extra').gen_ai_spec.indent(),
          L = require('mini.extra').gen_ai_spec.line(),
          N = require('mini.extra').gen_ai_spec.number(),
          o = require('mini.ai').gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          u = require('mini.ai').gen_spec.function_call(), -- u for "Usage"
          U = require('mini.ai').gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
          f = require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            {
              '%u[%l%d]+%f[^%l%d]',
              '%f[%S][%l%d]+%f[^%l%d]',
              '%f[%P][%l%d]+%f[^%l%d]',
              '^[%l%d]+%f[^%l%d]',
            },
            '^().*()$',
          },
          g = function() -- Whole buffer, similar to `gg` and 'G' motion
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      })
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

  {
    'echasnovski/mini.pick',
    version = false,
    lazy = false,
    config = function()
      require('mini.pick').setup({
        options = {
          content_from_bottom = true,
        },
        window = {
          prompt_prefix = ' ❯ ',
          config = {
            border = vim.g.border_style,
          },
        },
        mappings = {
          to_quickfix = {
            char = '<c-q>',
            func = function()
              local items = MiniPick.get_picker_items() or {}
              MiniPick.default_choose_marked(items)
              MiniPick.stop()
            end,
          },
          all_to_quickfix = {
            char = '<A-q>',
            func = function()
              local matched_items = MiniPick.get_picker_matches().all or {}
              MiniPick.default_choose_marked(matched_items)
              MiniPick.stop()
            end,
          },
        },
      })
    end,
    keys = {
      { '<leader>sf', '<cmd>lua MiniPick.builtin.files()<CR>', desc = '[S]earch [F]iles' },
      { '<leader>so', '<cmd>lua MiniExtra.pickers.oldfiles()<CR>', desc = '[S]earch [O]ldfiles' },
      { '<leader>sgf', '<cmd>lua MiniExtra.pickers.git_files()<CR>', desc = '[S]earch [G]it [F]iles' },
      { '<leader>sw', '<cmd>lua MiniPick.builtin.grep()<CR>', desc = '[S]earch current [W]ord' },
      { '<leader>sgg', '<cmd>lua MiniPick.builtin.grep_live()<CR>', desc = '[S]earch by [G]rep' },
      { '<leader>sr', '<cmd>lua MiniPick.builtin.resume()<CR>', desc = '[S]earch [R]esume' },
      { '<leader>sk', '<cmd>lua MiniExtra.pickers.keymaps()<CR>', desc = '[S]earch [K]eymaps' },
      { '<leader>sc', '<cmd>lua MiniExtra.pickers.commands()<CR>', desc = '[S]earch [C]ommands' },
      { '<leader>sd', '<cmd>lua MiniExtra.pickers.diagnostic()<CR>', desc = '[S]earch [D]iagnostics' },
      { '<leader>sb', '<cmd>lua MiniPick.builtin.buffers()<CR>', desc = '[S]earch [B]uffers' },
      { '<leader>sh', '<cmd>lua MiniPick.builtin.help()<CR>', desc = '[S]earch [H]elp' },
      { '<leader>s/', '<cmd>lua MiniExtra.pickers.buf_lines()<CR>', desc = '[S]earch [/] in current buffer' },
    },
  },
  {
    'echasnovski/mini-git',
    version = false,
    lazy = false,
    config = function()
      require('mini.git').setup()
    end,
  },

  {
    'echasnovski/mini.diff',
    version = false,
    lazy = false,
    config = function()
      require('mini.diff').setup()
    end,
  },
  {
    {
      'echasnovski/mini.statusline',
      version = false,
      lazy = false,
      config = function()
        require('mini.statusline').setup({
          use_icons = vim.g.have_nerd_font,
          content = {
            active = function()
              local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
              local git = MiniStatusline.section_git({ trunc_width = 40 })
              local diff = MiniStatusline.section_diff({ trunc_width = 75 })
              local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
              -- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
              local filename = MiniStatusline.section_filename({ trunc_width = 140 })
              local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
              local location = MiniStatusline.section_location({ trunc_width = 200 })
              local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
              local macro = vim.g.macro_recording

              return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFilename', strings = { macro } },
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl, strings = { search, location } },
              })
            end,
          },
        })
      end,
    },
  },
}
