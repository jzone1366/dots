local map = require('zone.utils').map

require('zone.plugins.nvim-tree.mappings')
require('zone.plugins.auto-session.mappings')


-- Quickfix mappings
map('n', '<leader>ck', ':cexpr []<cr>')
map('n', '<leader>cc', ':cclose <cr>')
map('n', '<leader>co', ':copen <cr>')
map('n', '<leader>cf', ':cfdo %s/')

-- Buffer nav
map('n', '<leader>bp', ':bprev<cr>')
map('n', '<leader>bn', ':bnext<cr>')

-- quickfix navigation
map('n', '<leader>cp', ':cprev<cr>zz')
map('n', '<leader>cn', ':cnext<cr>zz')

-- tab navigation
map('n', '<leader>tp', ':tabprevious<cr>')
map('n', '<leader>tn', ':tabnext<cr>')
