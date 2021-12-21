-- attach any functions you want to use to M
local M = {}
local diagnostics_active = true

function M.toggle_diagnostics()
  if diagnostics_active then
    vim.diagnostic.disable()
    diagnostics_active = false
  else
    vim.diagnostic.enable()
    diagnostics_active = true
  end
end

return M

-- In config/mappings.lua
-- local map = require('zone.utils').map
-- map('n', '<leader>tt', '<cmd>lua require("zone.config.utils").toggle_diagnostics()<cr>')
