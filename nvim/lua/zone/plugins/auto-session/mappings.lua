local map = require('zone.utils').map

-- session
map('n', '<leader>sl', '<cmd>silent RestoreSession<cr>', { desc = 'Restore Session' })
map('n', '<leader>ss', '<cmd>SaveSession<cr>', { desc = 'Save Session' })
map(
  'n',
  '<leader>si',
  '<cmd>lua require("zone.utils.logger"):log(require("auto-session-library").current_session_name())<cr>',
  { desc = 'Print Session' }
)
