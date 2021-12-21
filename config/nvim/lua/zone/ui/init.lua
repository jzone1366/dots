local utils = require('zone.ui.utils')
local M = {}

local default_user_opts = {
  border = 'rounded',
  rename = {
    prompt = '> ',
    popup_opts = {},
  },
  code_actions = {
    popup_opts = {},
  },
}

M.rename = function()
  return require('zone.ui.rename')(default_user_opts)
end

M.code_actions = function(opts)
  require('zone.ui.code-action').code_actions(opts or default_user_opts)
end

M.range_code_actions = function(opts)
  opts = utils.merge({
    params = vim.lsp.util.make_given_range_params(),
  }, opts or {})
  M.code_actions(opts)

end

return M

