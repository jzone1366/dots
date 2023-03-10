local icons = require('zone.theme.icons')
--local augroup_name = 'ZoneNvimNvimTree'
--local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

-- ARGUMENTS FOR SETUP.
-- SOME OF THESE ARE THE DEFAULT OPTIONS, JUST HERE FOR BREVITY.
local args = {
  respect_buf_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = icons.hint,
      info = icons.info,
      warning = icons.warn,
      error = icons.error,
    },
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 50,
    number = true,
    relativenumber = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
  renderer = {
    highlight_git = true,
    special_files = {},
    icons = {
      webdev_colors = true,
      glyphs = {
        default = '',
        symlink = icons.symlink,
        git = icons.git,
        folder = icons.folder,
      },
    },
  },
}

return {
  'kyazdani42/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup(args)
  end,
  init = function()
    require('zone.plugins.nvim-tree.mappings')
  end,
  cmd = {
    'NvimTreeClipboard',
    'NvimTreeFindFile',
    'NvimTreeOpen',
    'NvimTreeRefresh',
    'NvimTreeToggle',
  },
}
