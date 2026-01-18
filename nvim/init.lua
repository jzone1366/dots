if vim.fn.has('nvim-0.9') == 0 then
  error('Need NVIM 0.9 in order to run.')
end

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/nvim-mini/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Global utility functions and variables
vim.noti = vim.notify
_G.L = vim.log.levels
_G.I = vim.inspect
_G.swift = {
  resize_windows = function() end, -- stubbed
  term = nil,
}

-- inspect the contents of an object very quickly
function _G.P(...)
  local printables = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(printables, vim.inspect(v))
  end
  vim.schedule_wrap(print)(table.concat(printables, '\n'))
  return ...
end
_G.dbg = _G.P

function vim.dbg(msg, level, _opts)
  vim.schedule_wrap(P)(msg)
end

function vim.pprint(...)
  local s, args = pcall(vim.deepcopy, { ... })
  if not s then
    args = { ... }
  end
  vim.schedule_wrap(vim.notify)(vim.inspect(#args > 1 and args or unpack(args)))
end

function vim.wlog(...)
  if vim.in_fast_event() then
    return vim.schedule_wrap(vim.wlog)(...)
  end
  local d = debug.getinfo(2)
  return vim.fn.writefile(
    vim.fn.split(
      ':' .. d.short_src .. ':' .. d.currentline .. ':\n' .. vim.inspect(#{ ... } > 1 and { ... } or ...),
      '\n'
    ),
    '/tmp/nlog',
    'a'
  )
end

function vim.wlogclear()
  vim.fn.writefile({}, '/tmp/nlog')
end

function _G.prequire(name)
  local ok, mod = pcall(require, name)
  if ok then
    return mod
  else
    vim.notify_once(string.format('Missing module: %s', mod), vim.log.levels.WARN)
    return nil
  end
end

require('core')
