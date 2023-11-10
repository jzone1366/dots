-- set up lazy.nvim to install plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local u = require('utils.core')
local ui = require('theme.ui')

-- Load plugin specs from lua/plugins/*.lua
require('lazy').setup('plugins', {
  lockfile = u.get_install_dir() .. '/lazy-lock.json',
  defaults = { lazy = true },
  ui = {
    border = ui.border,
    size = { width = 0.7, height = 0.7 },
  },
  change_detection = {
    notify = false,
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
