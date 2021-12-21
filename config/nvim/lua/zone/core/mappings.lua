local map = require('zone.utils').map

-- Quickfix mappings
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')

require('zone.plugins.auto-session.mappings')
require('zone.plugins.telescope.mappings').init()
require('zone.plugins.nvim-tree.mappings')
require('zone.plugins.terminal.mappings')
require('zone.lsp.mappings')
