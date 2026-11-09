-- ┌─────┐
-- │ Git │
-- └─────┘

local add, later = vim.pack.add, Config.later

later(function()
  add({ 'https://github.com/sindrets/diffview.nvim' })

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
end)

-- committia: nicer commit message window (loaded at startup so it catches
-- the commit buffer when nvim is opened by git)
add({ 'https://github.com/rhysd/committia.vim' })

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
