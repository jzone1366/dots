local icons = require('theme').icons
local width = 50
return {
  'nvim-neo-tree/neo-tree.nvim',
  --branch = 'v3.0',
  keys = {
    {
      '<C-e>',
      --function()
      --  vim.cmd.Neotree('reveal', 'toggle=true')
      --end,
      '<cmd>Neotree toggle reveal position=left<cr>',
      desc = 'Toggle Neo-Tree',
    },
  },
  cmd = { 'Neotree' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'adelarsq/image_preview.nvim',
    {
      'ten3roberts/window-picker.nvim',
      name = 'window-picker',
      config = function()
        local picker = require('window-picker')
        picker.setup()
        picker.pick_window = function()
          return picker.select({ hl = 'WindowPicker', prompt = 'Pick window: ' }, function(winid)
            return winid or nil
          end)
        end
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      desc = 'Load NeoTree if entering a directory',
      callback = function(args)
        if vim.fn.isdirectory(vim.api.nvim_buf_get_name(args.buf)) > 0 then
          require('lazy').load({ plugins = { 'neo-tree.nvim' } })
          vim.api.nvim_del_autocmd(args.id)
        end
      end,
    })
  end,
  config = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    require('neo-tree').setup({
      sources = {
        'filesystem',
        'git_status',
      },
      source_selector = {
        winbar = true,
        -- statusbar = true,
        separator_active = ' ',
      },
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      enable_git_status = true,
      git_status_async = true,
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function(_args)
            vim.api.nvim_win_set_width(0, width)
          end,
        },
        -- {
        --   event = "neo_tree_buffer_leave",
        --   handler = function(args) vim.cmd("highlight! Cursor blend=0") end,
        -- },
        -- {
        --   event = "neo_tree_window_before_open",
        --   handler = function(args) end,
        -- },
        -- {
        --   event = "neo_tree_window_after_open",
        --   handler = function(args)
        --     vim.cmd("wincmd =")
        --     vim.api.nvim_win_set_width(0, width)
        --   end,
        -- },
        -- {
        --   event = "neo_tree_window_before_close",
        --   handler = function(args) end,
        -- },
        {
          event = 'neo_tree_window_after_close',
          handler = function(_args)
            swift.resize_windows()
            --vim.cmd('wincmd p')
          end,
        },
        {
          event = 'neo_tree_popup_buffer_enter',
          handler = function(_args)
            vim.cmd('highlight! Cursor blend=0')
          end,
        },
      },
      filesystem = {
        hijack_netrw_behavior = 'disabled', -- "open_current",
        use_libuv_file_watcher = true,
        group_empty_dirs = false,
        follow_current_file = {
          enabled = false,
          leave_dirs_open = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            '.DS_Store',
          },
        },
      },
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        icon = {
          folder_empty = '',
        },
        git_status = {
          symbols = {
            added = icons.git.add,
            deleted = icons.git.remove,
            modified = icons.git.mod,
            renamed = icons.git.rename,
            untracked = '',
            ignored = '',
            unstaged = icons.git.unstaged,
            staged = '',
            conflict = '',
          },
        },
      },
      window = {
        position = 'left',
        width = width,
        mappings = {
          ['gp'] = 'image_preview', -- "<Leader>p" instead of "I" if you want the same as NvimTree
          o = 'toggle_node',
          ['/'] = 'noop',
          ['n'] = 'noop',
          ['<c-/>'] = 'fuzzy_finder',
          -- ["<c-o>"] = "open",
          -- ["<c-s>"] = "open_split",
          -- ["<CR>"] = "open_vsplit",
          ['<CR>'] = 'open_with_window_picker',
          ['<C-s>'] = 'split_with_window_picker',
          ['<C-o>'] = 'vsplit_with_window_picker',
          ['<esc>'] = 'revert_preview',
          ['P'] = { 'toggle_preview', config = { use_float = true } },
        },
      },
      commands = {
        image_preview = function(state)
          local node = state.tree:get_node()
          if node.type == 'file' then
            require('swift.utils').preview_file(node.path)
          end
        end,
      },
    })
  end,
}
