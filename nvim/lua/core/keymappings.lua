local map = require('utils').map


-- Fix moving forward in jumplist via <C-i>
map('n', '<C-I>', '<C-I>', { silent = true, desc = 'Move forward in jumplist' })

-- PACKAGE-INFO
-- Show dependency versions
map({ "n" }, "<LEADER>ns", require("package-info").show,
  { silent = true, noremap = true, desc = 'Show dependency versions' })
-- Hide dependency versions
map({ "n" }, "<LEADER>nc", require("package-info").hide,
  { silent = true, noremap = true, desc = 'Hide dependency versions' })
-- Toggle dependency versions
map({ "n" }, "<LEADER>nt", require("package-info").toggle,
  { silent = true, noremap = true, desc = 'Toggle dependency versions' })
-- Update dependency on the line
map({ "n" }, "<LEADER>nu", require("package-info").update,
  { silent = true, noremap = true, desc = 'Update dependency' })
-- Delete dependency on the line
map({ "n" }, "<LEADER>nd", require("package-info").delete,
  { silent = true, noremap = true, desc = 'Delete dependency' })
-- Install a new dependency
map({ "n" }, "<LEADER>ni", require("package-info").install,
  { silent = true, noremap = true, desc = 'Install dependency' })
-- Install a different dependency version
map({ "n" }, "<LEADER>np", require("package-info").change_version,
  { silent = true, noremap = true, desc = 'Change dependency version' })

-- Better window movement
map('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Move to the window to the left' })
map('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Move to the window below' })
map('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Move to the window above' })
map('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Move to the window to the right'})

-- H to move to the first non-blank character of the line
map('n', 'H', '^', { silent = true, desc = 'Move to the first non-blank character of the line'})
