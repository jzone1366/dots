local map = require('zone.utils').map

-- session
map('n', '<leader>sl', ':silent RestoreSession<cr>')
map('n', '<leader>ss', ':SaveSession<cr>')
