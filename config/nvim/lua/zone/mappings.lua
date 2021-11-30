local map = require('zone.utils').map

-- Quickfix mappings
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')

-- make Y behave like others
map('n', 'Y', 'y$')

require('zone.core.session.mappings')
require('zone.core.navigation.mappings').init()
require('zone.core.file-explorer.mappings')
require('zone.core.terminal.mappings')
require('zone.lsp.mappings')
