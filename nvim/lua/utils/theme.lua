local M = {}

M.set_highlight = function(hi, colors)
  local hi_str = ''

  for k, v in pairs(colors) do
    hi_str = hi_str .. k .. '=' .. v .. ' '
  end

  vim.cmd(('hi %s %s'):format(hi, hi_str))
end

M.get_highlight = function(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

return M
