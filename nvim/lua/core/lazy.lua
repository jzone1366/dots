-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)
-- settings and autocmds must load before plugins,
-- but we can manually enable caching before both
-- of these for optimal performance
local lc_ok, lazy_cache = pcall(require, 'lazy.core.cache')
if lc_ok then
  lazy_cache.enable()
end

local le_ok, lazy_event = pcall(require, 'lazy.core.handler.event')
if le_ok then
  lazy_event.mappings.LazyFile =
    { id = 'LazyFile', event = { 'BufReadPre', 'BufReadPost', 'BufNewFile', 'BufWritePre' } }
  lazy_event.mappings['User LazyFile'] = lazy_event.mappings.LazyFile
end

local plugin_spec = {
  { import = 'specs' },
}

require('lazy').setup(plugin_spec, {
  -- rocks = true,
  -- debug = false,
  -- defaults = { lazy = true },
  checker = { enabled = true },
  concurrency = 5,
  install = {
    missing = true,
    colorscheme = { vim.g.colorscheme, 'habamax' },
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
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
        'tutor_mode_plugin',
        'remote_plugins',
        'shada_plugin',
        'filetype',
        'spellfile',
        'tohtml',
      },
    },
  },
})
