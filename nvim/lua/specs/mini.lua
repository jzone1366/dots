local ui = require('theme')
local utils = require('utils')

return {
  {
    'nvim-mini/mini.icons',
    enabled = true,
    version = false,
    config = function()
      require('mini.icons').setup()
      -- Mocks nvim-web-devicons, for plugins that don't support Mini.Icons
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  {
    'nvim-mini/mini.align',
    enabled = true,
    version = false,
    opts = {
      mappings = {
        start = '<leader>a',
        start_with_preview = '<leader>A',
      },
    },
  },

  {
    'nvim-mini/mini.extra',
    lazy = false,
    version = false,
    config = function()
      require('mini.extra').setup()
    end,
  },

  {
    'nvim-mini/mini.pick',
    version = false,
    lazy = false,
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
            border = ui.border_style,
          },
        },
        delay = {
          -- Delay between forcing asynchronous behavior
          async = 10,

          -- Delay between computation start and visual feedback about it
          busy = 50,
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
      { '<leader>ff', '<cmd>Pick files<CR>', desc = ' [F]ind [F]iles ' },
      { '<leader>fo', '<cmd>Pick oldfiles<CR>', desc = ' [F]ind [O]ldfiles ' },
      { '<leader>fgf', '<cmd>Pick git_files<CR>', desc = ' [F]ind [G]it [F]iles ' },
      { '<leader>fw', '<cmd>Pick grep pattern="<cword>"<CR>', desc = ' [F]ind current [W]ord ' },
      { '<leader>fW', '<cmd>Pick grep pattern="<cWORD>"<CR>', desc = ' [F]ind current [W]ord ' },
      { '<leader>fgg', '<cmd>Pick grep_live<CR>', desc = ' [F]ind by [G]rep ' },
      { '<leader>fr', '<cmd>Pick resume<CR>', desc = ' [F]ind [R]esume ' },
      { '<leader>fk', '<cmd>Pick keymaps<CR>', desc = ' [F]ind [K]eymaps ' },
      { '<leader>fc', '<cmd>Pick commands<CR>', desc = ' [F]ind [C]ommands ' },
      { '<leader>fd', '<cmd>Pick diagnostic<CR>', desc = ' [F]ind [D]iagnostics ' },
      { '<leader>fb', '<cmd>Pick buffers<CR>', desc = ' [F]ind [B]uffers ' },
      { '<leader>fh', '<cmd>Pick help<CR>', desc = ' [F]ind [H]elp ' },
      { '<leader>f/', '<cmd>Pick buf_lines<CR>', desc = ' [F]ind [/] in current buffer ' },
    },
  },

  {
    'nvim-mini/mini.comment',
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
    'nvim-mini/mini.notify',
    event = 'VeryLazy',
    config = function()
      local win_config = function()
        local has_statusline = vim.o.laststatus > 0
        local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - bottom_space, border = 'none' }
      end
      require('mini.notify').setup({ window = { config = win_config } })
    end,
  },

  {
    'nvim-mini/mini.indentscope',
    config = function()
      require('mini.indentscope').setup({
        symbol = ui.indent_scope_char,
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

      utils.augroup('mini.indentscope', {
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
    'nvim-mini/mini.surround',
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
    'nvim-mini/mini.ai',
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
    'nvim-mini/mini.pairs',
    enabled = false,
    opts = {},
  },

  {
    'nvim-mini/mini.clue',
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
      'nvim-mini/mini.statusline',
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
  { 'nvim-mini/mini.files', version = '*', opts = true },
}
