local icons = require 'zone.theme.icons'
local M = {}

function M.status_clients()
  return function()
    local udap = package.loaded['zone.dap']
    if not udap then
      return ''
    end
    local session = require('dap').session()
    return session ~= nil and session.config ~= nil and session.config.type or '', icons.debug
  end
end

local register = require('zone.statusline.providers').register

register('dap_clients', M.status_clients())

return M
