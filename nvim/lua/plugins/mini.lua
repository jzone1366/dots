local SETTINGS = swift.req('swift.settings')

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
    'echasnovski/mini.extra',
    lazy = false,
    version = false,
    config = function()
      require('mini.extra').setup()
    end,
  },
  {
    'echasnovski/mini.pick',
    version = false,
    lazy = false,
    cond = vim.g.picker == 'mini',
    config = function()
      local picker = require('mini.pick')
      vim.ui.select = picker.ui_select
      picker.setup({
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
      { '<leader>ff', '<cmd>lua MiniPick.builtin.files()<CR>', desc = ' [F]ind [F]iles ' },
      { '<leader>fo', '<cmd>lua MiniExtra.pickers.oldfiles()<CR>', desc = '[F]ind [O]ldfiles' },
      { '<leader>fgf', '<cmd>lua MiniExtra.pickers.git_files()<CR>', desc = '[F]ind [G]it [F]iles' },
      { '<leader>fw', '<cmd>lua MiniPick.builtin.grep()<CR>', desc = '[F]ind current [W]ord' },
      { '<leader>fgg', '<cmd>lua MiniPick.builtin.grep_live()<CR>', desc = '[F]ind by [G]rep' },
      { '<leader>fr', '<cmd>lua MiniPick.builtin.resume()<CR>', desc = '[F]ind [R]esume' },
      { '<leader>fk', '<cmd>lua MiniExtra.pickers.keymaps()<CR>', desc = '[F]ind [K]eymaps' },
      { '<leader>fc', '<cmd>lua MiniExtra.pickers.commands()<CR>', desc = '[F]ind [C]ommands' },
      { '<leader>fd', '<cmd>lua MiniExtra.pickers.diagnostic()<CR>', desc = '[F]ind [D]iagnostics' },
      { '<leader>fb', '<cmd>lua MiniPick.builtin.buffers()<CR>', desc = '[F]ind [B]uffers' },
      { '<leader>fh', '<cmd>lua MiniPick.builtin.help()<CR>', desc = '[F]ind [H]elp' },
      { '<leader>f/', '<cmd>lua MiniExtra.pickers.buf_lines()<CR>', desc = '[F]ind [/] in current buffer' },
    },
  },
  {
    'echasnovski/mini.comment',
    cond = false,
    version = false,
    opts = {
      -- Options which control module behavior
      options = {
        -- Function to compute custom 'commentstring' (optional)
        custom_commentstring = nil,

        -- Whether to ignore blank lines when commenting
        ignore_blank_line = true,

        -- Whether to recognize as comment only lines without indent
        start_of_line = false,

        -- Whether to force single space inner padding for comment parts
        pad_comment_parts = true,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = 'gcc',

        -- Toggle comment on visual selection
        comment_visual = 'gc',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = 'gc',
      },

      -- Hook functions to be executed at certain stage of commenting
      hooks = {
        -- Before successful commenting. Does nothing by default.
        pre = function() end,
        -- After successful commenting. Does nothing by default.
        post = function() end,
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    cond = false,
    config = function()
      swift.req('mini.indentscope').setup({
        symbol = SETTINGS.indent_scope_char,
        -- mappings = {
        --   goto_top = "<leader>k",
        --   goto_bottom = "<leader>j",
        -- },
        draw = {
          delay = 0,
          animation = function()
            return 0
          end,
        },
        options = { try_as_border = true, border = 'both', indent_at_cursor = true },
      })

      swift.req('swift.autocmds').augroup('mini.indentscope', {
        {
          event = 'FileType',
          pattern = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'lazy',
            'mason',
            'fzf',
            'dirbuf',
            'terminal',
            'fzf-lua',
            'fzflua',
            'nofile',
            'terminal',
            'lsp-installer',
            'SidebarNvim',
            'lspinfo',
            'markdown',
            'help',
            'startify',
            'packer',
            'NeogitStatus',
            'oil',
            'DirBuf',
            'markdown',
          },
          command = function()
            vim.b.miniindentscope_disable = true
          end,
        },
      })
    end,
  },

  {
    'echasnovski/mini.surround',
    keys = {
      { 'S', mode = { 'x' } },
      'ys',
      'ds',
      'cs',
    },
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          replace = 'cs',
          find = '',
          find_left = '',
          highlight = '',
          update_n_lines = '',
        },
      })

      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]])
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    opts = {
      -- Highlight standalone "FIXME", "ERROR", "HACK", "TODO", "NOTE", "WARN", "REF"
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        error = { pattern = '%f[%w]()ERROR()%f[%W]', group = 'MiniHipatternsError' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        warn = { pattern = '%f[%w]()WARN()%f[%W]', group = 'MiniHipatternsWarn' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        ref = { pattern = '%f[%w]()REF()%f[%W]', group = 'MiniHipatternsRef' },
        refs = { pattern = '%f[%w]()REFS()%f[%W]', group = 'MiniHipatternsRef' },
        due = { pattern = '%f[%w]()@@()%f[%W]!', group = 'MiniHipatternsDue' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        -- hex_color = hipatterns.gen_highlighter.hex_color(),
      },
      -- vim.b.minihipatterns_disable = not context.in_treesitter_capture("comment") or not context.in_syntax_group("Comment")
    },
  },
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'o', 'x' } },
      { 'i', mode = { 'o', 'x' } },
    },
    config = function()
      local ai = require('mini.ai')
      local gen_spec = ai.gen_spec
      ai.setup({
        n_lines = 500,
        search_method = 'cover_or_next',
        custom_textobjects = {
          o = gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          -- t = { "<(%w-)%f[^<%w][^<>]->.-</%1>", "^<.->%s*().*()%s*</[^/]->$" }, -- deal with selection without the carriage return
          t = { '<([%p%w]-)%f[^<%p%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },

          -- scope
          s = gen_spec.treesitter({
            a = { '@function.outer', '@class.outer', '@testitem.outer' },
            i = { '@function.inner', '@class.inner', '@testitem.inner' },
          }),
          S = gen_spec.treesitter({
            a = { '@function.name', '@class.name', '@testitem.name' },
            i = { '@function.name', '@class.name', '@testitem.name' },
          }),
        },
        mappings = {
          around = 'a',
          inside = 'i',

          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',

          goto_left = '',
          goto_right = '',
        },
      })
    end,
  },
  {
    enabled = false,
    'echasnovski/mini.pairs',
    opts = {},
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
