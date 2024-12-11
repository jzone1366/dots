local M = {}
local fn = vim.fn

M.os_is_dark = function()
  return (vim.call(
    'system',
    [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
  )):find('dark') ~= nil
end

M.toggle_quicklist = function()
  if fn.empty(fn.filter(fn.getwininfo(), 'v:val.quickfix')) == 1 then
    vim.cmd('copen')
  else
    vim.cmd('cclose')
  end
end

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
