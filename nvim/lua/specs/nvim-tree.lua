local map = require('utils').map

return {
  'nvim-tree/nvim-tree.lua',
  enabled = false,
  cmd = {
    'NvimTreeOpen',
    'NvimTreeClose',
    'NvimTreeToggle',
    'NvimTreeFindFile',
    'NvimTreeFindFileToggle',
  },
  keys = {
    { '<C-e>', "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = 'NvimTree' },
  },
  config = function()
    local api = require('nvim-tree.api')

    local git_icons = {
      unstaged = '',
      staged = '',
      unmerged = '',
      renamed = '➜',
      untracked = '',
      deleted = '',
      ignored = '◌',
    }

    local function on_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      map('n', '<CR>', api.node.open.edit, opts('Open'))
      map('n', 'o', api.node.open.edit, opts('Open'))
      map('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
      map('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
      map('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
      map('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
      map('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
      map('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
      map('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
      map('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
      map('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
      map('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
      map('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
      map('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
      map('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
      map('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
      map('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
      map('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
      map('n', 'R', api.tree.reload, opts('Refresh'))
      map('n', 'a', api.fs.create, opts('Create'))
      map('n', 'd', api.fs.remove, opts('Delete'))
      map('n', 'D', api.fs.trash, opts('Trash'))
      map('n', 'r', api.fs.rename, opts('Rename'))
      map('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
      map('n', 'x', api.fs.cut, opts('Cut'))
      map('n', 'c', api.fs.copy.node, opts('Copy'))
      map('n', 'p', api.fs.paste, opts('Paste'))
      map('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      map('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
      map('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
      map('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
      map('n', ']c', api.node.navigate.git.next, opts('Next Git'))
      map('n', '-', api.tree.change_root_to_parent, opts('Up'))
      map('n', 's', api.node.run.system, opts('Run System'))
      map('n', 'q', api.tree.close, opts('Close'))
      map('n', 'g?', api.tree.toggle_help, opts('Help'))
      map('n', 'W', api.tree.collapse_all, opts('Collapse'))
      map('n', 'S', api.tree.search_node, opts('Search'))
    end

    require('nvim-tree').setup({
      on_attach = on_attach,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      sync_root_with_cwd = true,
      --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
      respect_buf_cwd = true,
      -- show lsp diagnostics in the signcolumn
      diagnostics = {
        enable = false,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        },
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = 'none',
        root_folder_label = ':~',
        indent_markers = {
          enable = false,
          icons = {
            corner = '└ ',
            edge = '│ ',
            none = '  ',
          },
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            git = git_icons,
          },
        },
      },
      -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
      update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_root = true,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {},
      },
      -- configuration options for the system open command (`s` in the tree by default)
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = {},
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          -- if true the tree will resize itself after opening a file
          resize_window = false,
          window_picker = {
            enable = true,
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
      },
      view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 40,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = 'left',
        number = false,
        relativenumber = false,
      },
    })

    vim.api.nvim_set_keymap(
      'n',
      '<C-e>',
      "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>",
      { noremap = true, silent = true, desc = 'NvimTreeToggle' }
    )
  end,
}
