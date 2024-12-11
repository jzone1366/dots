local map = require('utils').map

-- Fix moving forward in jumplist via <C-i>
map('n', '<C-I>', '<C-I>', { silent = true, desc = 'Move forward in jumplist' })

-- Better window movement
map('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Move to the window to the left' })
map('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Move to the window below' })
map('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Move to the window above' })
map('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Move to the window to the right' })

-- H to move to the first non-blank character of the line
map('n', 'H', '^', { silent = true, desc = 'Move to the first non-blank character of the line' })

-- UTIL Mappings
map('n', '<LEADER>/u', '<cmd>Lazy update<CR>', { silent = true, desc = 'update plugins' })
map('n', '<LEADER>/i', '<cmd>Lazy<CR>', { silent = true, desc = 'manage plugins' })
map('n', '<LEADER>//', '<cmd>Alpha<CR>', { silent = true, desc = 'open dashboard' })
map('n', '<LEADER>c', 'e $MYVIMRC', { silent = true, desc = 'open config' })
