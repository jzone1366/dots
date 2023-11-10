local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = M.merge(options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.create_buf_map(bufnr, opts)
  return function(mode, lhs, rhs, map_opts)
    M.map(
      mode,
      lhs,
      rhs,
      M.merge({
        buffer = bufnr,
      }, opts or {}, map_opts or {})
    )
  end
end

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.split(str, sep)
  local res = {}
  for w in str:gmatch('([^' .. sep .. ']*)') do
    if w ~= '' then
      table.insert(res, w)
    end
  end
  return res
end

function M.get_active_lsp_client_names()
  local active_clients = vim.lsp.get_clients()
  local client_names = {}
  for _, client in pairs(active_clients or {}) do
    local buf = vim.api.nvim_get_current_buf()
    -- only return attached buffers
    if vim.lsp.buf_is_attached(buf, client.id) then
      table.insert(client_names, client.name)
    end
  end

  if not vim.tbl_isempty(client_names) then
    table.sort(client_names)
  end
  return client_names
end

local function unload(module_pattern, reload)
  reload = reload or false
  for module, _ in pairs(package.loaded) do
    if module:match(module_pattern) then
      package.loaded[module] = nil
      if reload then
        require(module)
      end
    end
  end
end

function M.post_reload(msg)
  local Logger = require('utils.logger')
  unload('utils', true)
  unload('theme', true)
  msg = msg or 'User config reloaded!'
  Logger:log(msg)
end

function M.get_install_dir()
  local config_dir = os.getenv('ZONENVIM_INSTALL_DIR')
  if not config_dir then
    return vim.fn.stdpath('config')
  end
  return config_dir
end

-- update instance of ZoneNvim
function M.update()
  local Logger = require('utils.logger')
  local Job = require('plenary.job')
  local path = M.get_install_dir()
  local errors = {}

  Job:new({
    command = 'git',
    args = { 'pull', '--ff-only' },
    cwd = path,
    on_start = function()
      Logger:log('Updating...')
    end,
    on_exit = function()
      if vim.tbl_isempty(errors) then
        Logger:log('Updated! Running ZoneReloadSync...')
        M.reload_user_config_sync()
      else
        table.insert(errors, 1, 'Something went wrong! Please pull changes manually.')
        table.insert(errors, 2, '')
        Logger:error('Update failed!', { timeout = 30000 })
      end
    end,
    on_stderr = function(_, err)
      table.insert(errors, err)
    end,
  }):sync()
end

M.is_normal_win = function(winid)
  if vim.fn.win_gettype(winid) ~= '' then
    return false
  end
  local bufid = vim.api.nvim_win_get_buf(winid)
  if vim.api.nvim_get_option_value('buftype', { buf = bufid }) == '' then
    return false
  end
  if vim.tbl_contains({ 'NvimTree', 'Trouble', 'aerial' }, vim.api.nvim_get_option_value('filetype', { buf = bufid })) then
    return false
  end
  return true
end

M.tbl_reduce = function(tbl, fn, acc)
  for k, v in pairs(tbl) do
    acc = fn(acc, v, k)
  end
  return acc
end

M.tbl_listkeys = function(tbl)
  return M.tbl_reduce(tbl, function(acc, v, k)
    if type(k) == 'number' then
      table.insert(acc, v)
    else
      table.insert(acc, k)
    end
    return acc
  end, {})
end

M.get_runtime_path = function()
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')
end

return M
