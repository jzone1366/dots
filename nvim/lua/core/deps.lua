-- Mini.deps plugin manager setup
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Load mini.nvim modules early
now(function()
  require('mini.notify').setup({
    window = {
      config = function()
        local has_statusline = vim.o.laststatus > 0
        local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - bottom_space, border = 'none' }
      end,
    },
  })
  vim.notify = MiniNotify.make_notify()
end)

now(function()
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end)

now(function()
  require('mini.statusline').setup({
    use_icons = vim.g.have_nerd_font,
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 200 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
        local macro = vim.g.macro_recording

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=',
          { hl = 'MiniStatuslineFilename', strings = { macro } },
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
    },
  })
end)

-- Load mini modules later for better startup time
later(function()
  require('mini.align').setup({
    mappings = {
      start = '<leader>a',
      start_with_preview = '<leader>A',
    },
  })
end)

later(function()
  require('mini.extra').setup()
end)

later(function()
  local ui = require('theme')
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
      async = 10,
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

  -- Setup keymappings for mini.pick
  vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<CR>', { desc = ' [F]ind [F]iles ' })
  vim.keymap.set('n', '<leader>fo', '<cmd>Pick oldfiles<CR>', { desc = ' [F]ind [O]ldfiles ' })
  vim.keymap.set('n', '<leader>fgf', '<cmd>Pick git_files<CR>', { desc = ' [F]ind [G]it [F]iles ' })
  vim.keymap.set('n', '<leader>fw', '<cmd>Pick grep pattern="<cword>"<CR>', { desc = ' [F]ind current [W]ord ' })
  vim.keymap.set('n', '<leader>fW', '<cmd>Pick grep pattern="<cWORD>"<CR>', { desc = ' [F]ind current [W]ord ' })
  vim.keymap.set('n', '<leader>fgg', '<cmd>Pick grep_live tool="rg"<CR>', { desc = ' [F]ind by [G]rep ' })
  vim.keymap.set('n', '<leader>fr', '<cmd>Pick resume<CR>', { desc = ' [F]ind [R]esume ' })
  vim.keymap.set('n', '<leader>fk', '<cmd>Pick keymaps<CR>', { desc = ' [F]ind [K]eymaps ' })
  vim.keymap.set('n', '<leader>fc', '<cmd>Pick commands<CR>', { desc = ' [F]ind [C]ommands ' })
  vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<CR>', { desc = ' [F]ind [D]iagnostics ' })
  vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<CR>', { desc = ' [F]ind [B]uffers ' })
  vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<CR>', { desc = ' [F]ind [H]elp ' })
  vim.keymap.set('n', '<leader>f/', '<cmd>Pick buf_lines<CR>', { desc = ' [F]ind [/] in current buffer ' })
end)

later(function()
  require('mini.comment').setup({
    options = {
      custom_commentstring = nil,
      ignore_blank_line = true,
      start_of_line = false,
      pad_comment_parts = true,
    },
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'gc',
    },
    hooks = {
      pre = function() end,
      post = function() end,
    },
  })
end)

later(function()
  local ui = require('theme')
  local utils = require('utils')
  require('mini.indentscope').setup({
    symbol = ui.indent_scope_char,
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
end)

later(function()
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
end)

later(function()
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
      t = { '<([%p%w]-)%f[^<%p%w][^<>]->.-</%1>', '^<.->().*()</[^/]->' },
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
end)

later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    window = {
      delay = 0,
      config = {
        width = 'auto',
        border = 'double',
      },
    },
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'i', keys = '<C-x>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },
    clues = {
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
end)

later(function()
  require('mini.files').setup()
end)

-- Load external plugins
later(function()
  -- Colorscheme
  add({
    source = 'catppuccin/nvim',
    name = 'catppuccin',
  })

  local utils = require('utils')
  local config = {
    flavour = 'auto',
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    integrations = {
      alpha = true,
      blink_cmp = true,
      dap = true,
      diffview = true,
      fidget = true,
      flash = true,
      lsp_trouble = true,
      mason = true,
      mini = {
        enabled = true,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
          ok = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
      navic = {
        enabled = true,
        custom_bg = 'NONE',
      },
      neotree = true,
      notify = true,
    },
  }

  require('catppuccin').setup(config)
  vim.cmd('colorscheme catppuccin')

  if utils.os_is_dark() then
    vim.cmd('set background=dark')
  else
    vim.cmd('set background=light')
  end
end)

-- Treesitter
later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = {
      post_checkout = function()
        vim.cmd('TSUpdate')
      end,
    },
  })

  local function should_disable(lang, bufnr)
    local disable_max_size = 2000000
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr or 0))
    if size > disable_max_size or size == -2 then
      return true
    end
    if vim.tbl_contains({ 'ruby' }, lang) then
      return true
    end
    return false
  end

  vim.treesitter.language.register('bash', 'zsh')
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
    end,
  })

  local ft_to_parser_aliases = {
    dotenv = 'bash',
    gitcommit = 'NeogitCommitMessage',
    javascriptreact = 'jsx',
    json = 'jsonc',
    keymap = 'devicetree',
    kittybuf = 'bash',
    typescriptreact = 'tsx',
    zsh = 'bash',
  }

  for ft, parser in pairs(ft_to_parser_aliases) do
    vim.treesitter.language.register(parser, ft)
  end

  require('nvim-treesitter.install').prefer_git = true
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'csv',
      'comment',
      'devicetree',
      'dockerfile',
      'diff',
      'elm',
      'embedded_template',
      'erlang',
      'fish',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'gleam',
      'go',
      'graphql',
      'heex',
      'html',
      'javascript',
      'jq',
      'jsdoc',
      'json',
      'jsonc',
      'json5',
      'lua',
      'luadoc',
      'luap',
      'make',
      'markdown',
      'markdown_inline',
      'nix',
      'perl',
      'printf',
      'psv',
      'python',
      'query',
      'regex',
      'ruby',
      'rust',
      'scss',
      'scheme',
      'sql',
      'surface',
      'terraform',
      'tmux',
      'toml',
      'tsv',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    ignore_install = { 'comment' },
    auto_install = true,
    sync_install = false,
    highlight = {
      enable = vim.g.vscode ~= 1,
      disable = should_disable,
      use_languagetree = true,
      additional_vim_regex_highlighting = {
        'ruby',
        'python',
        'vim',
      },
    },
    indent = {
      enable = true,
      disable = function(lang, bufnr)
        if vim.tbl_contains({ 'lua' }, lang) then
          return true
        else
          return should_disable(lang, bufnr)
        end
      end,
    },
    endwise = { enable = true },
    matchup = {
      enable = true,
      include_match_words = true,
      disable = function(lang, bufnr)
        if vim.tbl_contains({ 'ruby', 'typescriptreact', 'javascriptreact', 'typescript', 'javascript' }, lang) then
          return true
        else
          return should_disable(lang, bufnr)
        end
      end,
      disable_virtual_text = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<cr>',
        node_incremental = '<cr>',
        node_decremental = '<bs>',
        scope_incremental = false,
      },
    },
  })
end)

-- Treesitter extensions
later(function()
  add('nvim-treesitter/nvim-treesitter-textobjects')
  add('RRethy/nvim-treesitter-textsubjects')
  add('nvim-treesitter/nvim-tree-docs')
end)

later(function()
  add('nvim-treesitter/nvim-treesitter-context')
  require('treesitter-context').setup({
    separator = '▁',
    max_lines = 2,
    trim_scope = 'outer',
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
        'element',
        'call',
      },
    },
    exact_patterns = {},
    zindex = 20,
    mode = 'cursor',
  })

  vim.keymap.set('n', '[[', function()
    require('treesitter-context').go_to_context(-vim.v.count1)
  end, { desc = 'Jump to previous context' })
  vim.keymap.set('n', ']]', function()
    require('treesitter-context').go_to_context(vim.v.count1)
  end, { desc = 'Jump to next context' })
end)

later(function()
  add('andymass/vim-matchup')
  vim.g.matchup_matchparen_nomode = 'i'
  vim.g.matchup_delim_noskips = 1
  vim.g.matchup_matchparen_deferred_show_delay = 400
  vim.g.matchup_matchparen_deferred_hide_delay = 400
  vim.g.matchup_matchparen_offscreen = {}
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_timeout = 300
  vim.g.matchup_matchparen_insert_timeout = 60
  vim.g.matchup_surround_enabled = 1
  vim.g.matchup_motion_enabled = 1
  vim.g.matchup_text_obj_enabled = 1
end)

later(function()
  add('David-Kunz/treesitter-unit')
  
  vim.keymap.set('x', 'iu', ':lua require"treesitter-unit".select()<CR>', { desc = 'Select inner treesitter unit' })
  vim.keymap.set('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', { desc = 'Select inner treesitter unit' })
  vim.keymap.set('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', { desc = 'Select around treesitter unit' })
  vim.keymap.set('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', { desc = 'Select around treesitter unit' })
end)

later(function()
  add('yorickpeterse/nvim-tree-pairs')
  require('tree-pairs').setup()
end)

later(function()
  add('HiPhish/rainbow-delimiters.nvim')
  local rainbow = require('rainbow-delimiters')
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow.strategy['global'],
      vim = rainbow.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
      html = 'rainbow-tags',
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
    blacklist = { 'c', 'cpp' },
  }
end)

later(function()
  add('mtrajano/tssorter.nvim')
end)

-- Git plugins
later(function()
  add('lewis6991/gitsigns.nvim')
  require('gitsigns').setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = 'Jump to previous git [c]hange' })

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'git [s]tage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'git [r]eset hunk' })
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis('@')
      end, { desc = 'git [D]iff against last commit' })
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
    end,
  })
end)

later(function()
  add('rhysd/committia.vim')
  vim.g.committia_min_window_width = 30
  vim.g.committia_edit_window_width = 100
  vim.g.committia_use_singlecolumn = 'always'
end)

later(function()
  add('sindrets/diffview.nvim')
  
  -- Diffview keymappings
  vim.keymap.set('n', '<leader>gd', function()
    vim.cmd('DiffviewOpen')
  end, { desc = 'diffview: open' })
  vim.keymap.set('v', 'gh', [[:'<'>DiffviewFileHistory<CR>]], { desc = 'diffview: file history' })
  vim.keymap.set('n', '<localleader>gh', '<Cmd>DiffviewFileHistory<CR>', { desc = 'diffview: file history' })
end)

-- LSP
now(function()
  add({
    source = 'neovim/nvim-lspconfig',
    depends = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'b0o/schemastore.nvim',
      'j-hui/fidget.nvim',
    },
  })
  add('folke/lazydev.nvim')
  add('Bilal2453/luvit-meta')
  add('rachartier/tiny-inline-diagnostic.nvim')
  add('wochap/lsp-lens.nvim')
  add('aznhe21/actions-preview.nvim')
  add('SmiteshP/nvim-navbuddy')
  add('SmiteshP/nvim-navic')

  -- Setup LSP configurations
  require('mason').setup()
  require('fidget').setup()
  
  -- Lazydev for lua LSP
  require('lazydev').setup({
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      { path = 'mini.icons', words = { 'MiniIcons' } },
      { path = 'mini.pick', words = { 'MiniPick' } },
    },
  })

  -- Tiny inline diagnostics
  require('tiny-inline-diagnostic').setup({
    preset = 'modern',
    multilines = true,
  })
  vim.diagnostic.config({ virtual_text = false })

  -- LSP lens
  require('lsp-lens').setup({
    enable = true,
    include_declaration = false,
    sections = {
      definition = false,
      references = function(count)
        return '  ' .. count .. ' '
      end,
      implements = false,
      git_authors = false,
    },
  })

  -- Actions preview
  local hl = require('actions-preview.highlight')
  require('actions-preview').setup({
    highlight_command = {
      hl.delta('delta --dark --paging=never'),
    },
  })
end)

-- Load LSP server configurations later
later(function()
  require('config.lsp')()
end)

-- Completion
later(function()
  add({
    source = 'Saghen/blink.cmp',
    depends = {
      'rafamadriz/friendly-snippets',
      'moyiz/blink-emoji.nvim',
      'fang2hou/blink-copilot',
      'MeanderingProgrammer/render-markdown.nvim',
      'xzbdmw/colorful-menu.nvim',
    },
  })

  require('config.blink')()
end)

-- Formatting
later(function()
  add('stevearc/conform.nvim')
  require('config.conform')()
end)

-- Linting
later(function()
  add('mfussenegger/nvim-lint')
  require('config.lint')()
end)

-- AI (copilot)
later(function()
  add('zbirenbaum/copilot.lua')
  require('config.copilot')()
end)

-- File explorer
later(function()
  add({
    source = 'nvim-neo-tree/neo-tree.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  })

  -- Neo-tree keymapping
  vim.keymap.set('n', '<C-e>', '<cmd>Neotree toggle reveal position=left<cr>', { desc = 'Toggle Neo-Tree' })
  
  -- Basic neo-tree setup - full config from specs/neo-tree.lua can be added if needed
  require('neo-tree').setup({
    sources = {
      'filesystem',
      'git_status',
    },
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
      },
    },
    window = {
      position = 'left',
      width = 50,
    },
  })
end)

-- Todo comments
later(function()
  add({
    source = 'folke/todo-comments.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  })
  
  require('todo-comments').setup()
end)

-- Additional utilities
later(function()
  add('nvim-lua/plenary.nvim')
end)

return {
  add = add,
  now = now,
  later = later,
}
