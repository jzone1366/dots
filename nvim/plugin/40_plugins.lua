-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local now, add, later = MiniDeps.now, MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

local has_words_before = function()
  if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Update tree-sitter parser after plugin is updated
    hooks = {
      post_checkout = function()
        vim.cmd('TSUpdate')
      end,
    },
  })
  add({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    -- Use `main` branch since `master` branch is frozen, yet still default
    -- It is needed for compatibility with 'nvim-treesitter' `main` branch
    checkout = 'main',
  })

  require('nvim-treesitter').setup({
    modules = {},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })

  -- Define languages which will have parsers installed and auto enabled
  local languages = {
    -- These are already pre-installed with Neovim. Used as an example.
    'bash',
    'c',
    'cpp',
    'css',
    'csv',
    'dockerfile',
    'diff',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'graphql',
    'html',
    'javascript',
    'jq',
    'jsdoc',
    'json',
    'json5',
    'lua',
    'luadoc',
    'luap',
    'make',
    'markdown',
    'markdown_inline',
    'perl',
    'printf',
    'python',
    'regex',
    'ruby',
    'rust',
    'scss',
    'sql',
    'terraform',
    'tmux',
    'toml',
    'tsv',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then
    require('nvim-treesitter').install(to_install)
  end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
  end
  _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
  add({
    source = 'neovim/nvim-lspconfig',
    depends = {
      'saghen/blink.cmp',
      'saghen/blink.compat',
      'nvim-lua/plenary.nvim',
    },
  })

  add({
    source = 'saghen/blink.cmp',
    checkout = 'v1.8.0',
    depends = {
      'xzbdmw/colorful-menu.nvim',
    },
  })
  add('zbirenbaum/copilot.lua')
  add({
    source = 'CopilotC-Nvim/CopilotChat.nvim',
    depends = { 'zbirenbaum/copilot.lua' },
  })
  add('giuxtaposition/blink-cmp-copilot')
  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  require('CopilotChat').setup({})

  -- CodeCompanion - Only add if not in a git commit buffer
  local is_git_commit = vim.fn.expand('%:t'):match('^COMMIT_EDITMSG$')
    or vim.fn.expand('%:t'):match('^git%-rebase%-todo$')
    or vim.bo.filetype == 'gitcommit'
    or vim.bo.filetype == 'gitrebase'

  if not is_git_commit then
    add({
      source = 'olimorris/codecompanion.nvim',
      depends = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
    })

    -- Setup codecompanion immediately after adding
    vim.schedule(function()
      local prompts = require('codecompanion.prompts')

      local prompt_library = {}
      for name, prompt in pairs(prompts) do
        local display_name = prompt.display_name
          or name:gsub('_', ' '):gsub("(%a)([%w_']*)", function(first, rest)
            return first:upper() .. rest:lower()
          end)

        prompt_library[display_name] = prompt.config
      end

      require('codecompanion').setup({
        strategies = {
          chat = { adapter = 'copilot' },
          inline = { adapter = 'copilot' },
          agent = { adapter = 'copilot' },
        },
        adapters = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-opus-4.5',
                },
              },
            })
          end,
        },
        prompt_library = prompt_library,
      })
    end)
  end

  -- LSP Config
  local blink_caps = require('blink.cmp').get_lsp_capabilities()
  local servers = {
    'bashls',
    'cssls',
    'denols',
    'dockerls',
    'eslint',
    'gopls',
    'html',
    'intelephense',
    'jsonls',
    'lua_ls',
    'prismals',
    'pyright',
    'csharp_ls',
    'rust_analyzer',
    'sqlls',
    'svelte',
    'tailwindcss',
    'terraformls',
    'ts_ls', --temporarily disabled, because of tsgo
    --'tsgo', -- turn on later and use instead of ts_ls
    'vimls',
    'yamlls',
  }

  -- Apply to every server unless you override later
  vim.lsp.config('*', {
    capabilities = blink_caps,
  })

  -- Avoid conflict with competing ts_ls and denols
  -- deno.json is not present, use ts_ls instead of denols
  vim.lsp.config('ts_ls', {
    single_file_support = false,
    workspace_required = true,
    root_markers = { 'package.json' },
  })

  vim.lsp.config('denols', {
    workspace_required = true,
    root_markers = { 'deno.json' },
  })

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim', 'MiniDeps' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      },
    },
  })

  local root_patterns = { '.git', 'deno.json', 'tsconfig.json', 'package.json', 'jsconfig.json', 'pyproject.toml' }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1] or vim.uv.cwd())

  -- Configure each LSP server
  for _, lsp in ipairs(servers) do
    -- Skip ts_ls if deno.json is present in the project root
    if not (lsp == 'ts_ls' and vim.fn.filereadable(root_dir .. '/deno.json') == 1) then
      vim.lsp.enable(lsp)
    end
  end

  require('blink.cmp').setup({
    --keymap = { preset = 'default' },
    fuzzy = { implementation = 'lua' },
    -- Set my own, and get rid of the ones I don't use
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-c>'] = { 'hide' },

      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if not has_words_before() then
            return
          end

          if cmp.is_menu_visible() then
            return cmp.select_next()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
    },

    completion = {
      accept = {
        -- Experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = 'rounded',
        draw = {
          padding = 1,
          gap = 2,
          columns = { { 'kind_icon' }, { 'label', 'kind', gap = 2 } },
          components = {
            label = {
              width = { fill = true },
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
            label_description = { width = { fill = true } },
            kind_icon = {
              text = function(ctx)
                local MiniIcons = require('mini.icons')
                local source = ctx.item.source_name
                local label = ctx.item.label
                local icon = source == 'LSP' and MiniIcons.get('lsp', ctx.kind)
                  or source == 'copilot' and MiniIcons.get('filetype', source)
                  or source == 'Path' and (label:match('%.[^/]+$') and MiniIcons.get('file', label) or MiniIcons.get(
                    'directory',
                    ctx.item.label
                  ))
                  or ctx.kind_icon

                return icon .. ' '
              end,
            },
          },
        },
      },

      documentation = {
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },

    cmdline = { enabled = false },

    sources = {
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          async = true,
          score_offset = 100, -- Copilot higher in list; lower if too aggressive
        },
      },

      default = { 'lsp', 'path', 'buffer', 'copilot' },
    },
  })
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add('stevearc/conform.nvim')

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    -- formatters_by_ft = { lua = { 'stylua' } },
    formatters_by_ft = {
      css = { 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports', 'gofmt' },
      graphql = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      lua = { 'stylua' },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      python = { 'isort', 'black' },
      ruby = { 'rubocop', 'rubyfmt', stop_after_first = true },
      rust = { 'rustfmt' },
      sql = { 'sql-formatter' },
      svelte = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
    },
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
  add('rafamadriz/friendly-snippets')
end)

now(function()
  add({ source = 'kepano/flexoki-neovim', as = 'flexoki' })

  vim.cmd('colorscheme flexoki-dark')
  vim.cmd('set background=dark')
end)

-- Other plugins ================================================================
later(function()
  add('rachartier/tiny-inline-diagnostic.nvim')
  require('tiny-inline-diagnostic').setup({
    preset = 'modern',
    multilines = true,
  })
  vim.diagnostic.config({ virtual_text = false })

  add('sindrets/diffview.nvim')

  require('diffview').setup({
    default_args = { DiffviewFileHistory = { '%' } },
    enhanced_diff_hl = true,
    view = {
      default = {
        -- Config for changed files, and staged files in diff views.
        layout = 'diff2_horizontal',
        disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
        winbar_info = false, -- See |diffview-config-view.x.winbar_info|
      },
      merge_tool = {
        -- Config for conflicted files in diff views during a merge or rebase.
        layout = 'diff3_mixed',
        disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
        winbar_info = true, -- See |diffview-config-view.x.winbar_info|
      },
    },
    hooks = {
      diff_buf_read = function()
        local opt = vim.opt_local
        opt.wrap = false
        opt.list = false
        opt.relativenumber = false
        opt.colorcolumn = ''
      end,
    },
    file_panel = {
      listing_style = 'tree',
      tree_options = {
        flatten_dirs = true,
        folder_statuses = 'only_folded',
      },
      win_config = function()
        return {
          type = 'split',
          position = 'right',
          width = 50,
        }
      end,
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = 'first-parent',
            follow = true,
          },
          multi_file = {
            diff_merges = 'first-parent',
          },
        },
      },
      win_config = {
        position = 'bottom',
        height = 16,
      },
    },
    keymaps = {
      -- disable_defaults = false, -- Disable the default keymaps
      view = { q = '<Cmd>DiffviewClose<CR>' },
      file_panel = { q = '<Cmd>DiffviewClose<CR>' },
      file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
    },
  })

  add('mfussenegger/nvim-lint')

  local lint = require('lint')
  lint.linters_by_ft = {
    javascript = {
      'eslint_d',
    },
    lua = {
      'luacheck',
    },
    markdown = {
      'vale',
    },
    php = {
      'phpcs',
    },
    python = {
      'pylint',
    },
    sh = {
      'shellcheck',
    },
    typescript = {
      'eslint_d',
    },
    typescriptreact = {
      'eslint_d',
    },
    yaml = {
      'yamllint',
    },
  }

  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      require('lint').try_lint()
    end,
  })
end)

add('aaronik/treewalker.nvim')
require('treewalker').setup({
  highlight = true,
  highlight_duration = 250,
  highlight_group = 'CursorLine',
})

MiniDeps.add({ source = 'rhysd/committia.vim' })

-- See: https://github.com/rhysd/committia.vim#variables
vim.g.committia_min_window_width = 30
vim.g.committia_edit_window_width = 100
vim.g.committia_use_singlecolumn = 'always'

vim.g.committia_hooks = {
  edit_open = function()
    vim.cmd.resize(25)
    local opts = {
      buffer = vim.api.nvim_get_current_buf(),
      silent = true,
    }
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    map('n', 'q', '<cmd>quit<CR>')
    map('i', '<C-d>', '<Plug>(committia-scroll-diff-down-half)')
    map('i', '<C-u>', '<Plug>(committia-scroll-diff-up-half)')
    map('i', '<C-f>', '<Plug>(committia-scroll-diff-down-page)')
    map('i', '<C-b>', '<Plug>(committia-scroll-diff-up-page)')
    map('i', '<C-j>', '<Plug>(committia-scroll-diff-down)')
    map('i', '<C-k>', '<Plug>(committia-scroll-diff-up)')
  end,
}
