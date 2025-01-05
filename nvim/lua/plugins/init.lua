local SETTINGS = require('swift.settings')

return {
  {
    { 'tpope/vim-eunuch', cmd = { 'Move', 'Rename', 'Remove', 'Delete', 'Mkdir', 'SudoWrite', 'Chmod' } },
    { 'tpope/vim-rhubarb', event = { 'VeryLazy' } },
    { 'tpope/vim-repeat', lazy = false },
    { 'tpope/vim-unimpaired', event = { 'VeryLazy' } },
    { 'tpope/vim-apathy', event = { 'VeryLazy' } },
    { 'tpope/vim-scriptease', event = { 'VeryLazy' }, cmd = { 'Messages', 'Mess', 'Noti' } },
    { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
    { 'ryvnf/readline.vim', event = 'CmdlineEnter' },
    {
      'farmergreg/vim-lastplace',
      lazy = false,
      init = function()
        vim.g.lastplace_ignore = 'gitcommit,gitrebase,svn,hgcommit,oil,neogitcommit,gitrebase'
        vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help,terminal'
        vim.g.lastplace_open_folds = true
      end,
    },
    {
      'brenoprata10/nvim-highlight-colors',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
        require('nvim-highlight-colors').setup(SETTINGS.highlight_color)
      end,
    },
    {
      'numToStr/Comment.nvim',
      dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        ignore = '^$', -- ignore blank lines
      },
      config = function(_, opts)
        require('Comment').setup(opts)
      end,
    },
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      aliases = {
        ['elixir'] = 'html',
        ['heex'] = 'html',
        ['phoenix_html'] = 'html',
      },
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    cond = true,
    lazy = true,
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup()

      npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      preview = {
        winblend = 0,
      },
    },
  },
  {
    'yorickpeterse/nvim-pqf',
    event = 'BufReadPre',
    config = function()
      local icons = require('swift.settings').icons
      require('pqf').setup({
        signs = {
          error = { text = icons.lsp.error, hl = 'DiagnosticSignError' },
          warning = { text = icons.lsp.warn, hl = 'DiagnosticSignWarn' },
          info = { text = icons.lsp.info, hl = 'DiagnosticSignInfo' },
          hint = { text = icons.lsp.hint, hl = 'DiagnosticSignHint' },
        },
        show_multiple_lines = true,
        max_filename_length = 40,
      })
    end,
  },
  {
    'OXY2DEV/helpview.nvim',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      windowCreationCommand = 'botright vsplit %',
    },
    config = function(_, opts)
      require('grug-far').setup(opts)
    end,
    cmd = {
      'GrugFar',
    },
    keys = {
      {
        '<localleader>er',
        [[<Cmd>GrugFar<CR>]],
        desc = '[grugfar] find and replace',
      },
      {
        '<localleader>eR',
        function()
          require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } })
        end,
        desc = '[grugfar] find and replace current word',
      },
      {
        '<C-r>',
        [[:<C-U>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })<CR>]],
        mode = { 'v', 'x' },
        desc = '[grugfar] find and replace visual selection',
      },
    },
  },
  {
    'tzachar/highlight-undo.nvim',
    opts = {},
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = function()
      local U = require('swift.utils')
      local ws_bg = U.hl.get_hl('Visual', 'bg')
      local ws_fg = U.hl.get_hl('Comment', 'fg')

      require('visual-whitespace').setup({
        highlight = { bg = ws_bg, fg = ws_fg },
        nl_char = '¬',
        excluded = {
          filetypes = { 'aerial' },
          buftypes = { 'help' },
        },
      })
    end,
  },
}
