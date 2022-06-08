local icons = require('zone.theme.icons')
local augroup_name = 'ZoneNvimNvimTree'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

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
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
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
    ignore = true,
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

vim.api.nvim_create_autocmd('BufEnter', {
  command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
  group = group,
  nested = true,
})

require('nvim-tree').setup(args)
