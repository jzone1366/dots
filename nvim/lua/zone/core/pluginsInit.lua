local u = require('zone.utils.core')
local ui = require('zone.theme.ui')

require('lazy').setup('zone.plugins', {
  lockfile = u.get_install_dir() .. '/lazy-lock.json',
  defaults = { lazy = true },
  ui = {
    border = ui.border,
    size = { width = 0.7, height = 0.7 },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'gzip',
        'zip',
        'zipPlugin',
        'tar',
        'tarPlugin',
        'getscript',
        'getscriptPlugin',
        'vimball',
        'vimballPlugin',
        '2html_plugin',
        'logipat',
        'rrhelper',
        'spellfile_plugin',
        'matchit',
      },
    },
  },
})
