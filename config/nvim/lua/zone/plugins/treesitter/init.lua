local config = require('zone.config')
local utils = require('zone.utils')

local defaults = {
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'php',
    'python',
    'scss',
    'tsx',
    'typescript',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
}

require('nvim-treesitter.configs').setup(utils.merge(defaults, config.treesitter or {}))
