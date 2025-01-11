local fn = vim.fn
local fmt = string.format

local M = {}

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

function M.is_chonky(bufnr, filepath)
  local max_filesize = 50 * 1024 -- 50 KB
  local max_length = 5000

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  filepath = filepath or vim.api.nvim_buf_get_name(bufnr)
  local is_too_long = vim.api.nvim_buf_line_count(bufnr) >= max_length
  local is_too_large = false

  local ok, stats = pcall(vim.uv.fs_stat, filepath)
  if ok and stats and stats.size > max_filesize then
    is_too_large = true
  end

  return (is_too_long or is_too_large)
end

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T : table
---@param callback fun(T, T, key: string | number): T
---@param list T[]
---@param accum T
---@return T
function M.fold(callback, list, accum)
  accum = accum or {}
  for k, v in pairs(list) do
    accum = callback(accum, v, k)
    assert(accum ~= nil, 'The accumulator must be returned on each iteration')
  end
  return accum
end

function M.augroup(name, commands)
  --- Validate the keys passed to swift.augroup are valid
  ---@param name string
  ---@param cmd Autocommand
  local function validate_autocmd(name, cmd)
    local keys = { 'event', 'buffer', 'pattern', 'desc', 'callback', 'command', 'group', 'once', 'nested', 'enabled' }
    local incorrect = M.fold(function(accum, _, key)
      if not vim.tbl_contains(keys, key) then
        table.insert(accum, key)
      end
      return accum
    end, cmd, {})
    if #incorrect == 0 then
      return
    end
    vim.schedule(function()
      vim.notify('Incorrect keys: ' .. table.concat(incorrect, ', '), vim.log.levels.ERROR, {
        title = fmt('Autocmd: %s', name),
      })
    end)
  end

  assert(name ~= 'User', 'The name of an augroup CANNOT be User')

  local auname = fmt('swift-%s', name)
  local id = vim.api.nvim_create_augroup(auname, { clear = true })

  for _, autocmd in ipairs(commands) do
    if autocmd.enabled == nil or autocmd.enabled == true then
      validate_autocmd(name, autocmd)
      local is_callback = type(autocmd.command) == 'function'
      vim.api.nvim_create_autocmd(autocmd.event, {
        group = id,
        pattern = autocmd.pattern,
        desc = autocmd.desc,
        callback = is_callback and autocmd.command or nil,
        command = not is_callback and autocmd.command or nil,
        once = autocmd.once,
        nested = autocmd.nested,
        buffer = autocmd.buffer,
      })
    end
  end

  return id
end

return M
