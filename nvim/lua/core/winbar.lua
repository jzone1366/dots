local icons = require('theme').icons

local M = {}

local status_navic_ok, navic = pcall(require, 'nvim-navic')
if not status_navic_ok then
  return
end

local function isempty(s)
  return s == nil or s == ''
end

M.filename = function()
  local filename = vim.fn.expand('%:t')
  local file_path = vim.fn.expand('%:p')
  local parent_dir = string.match(file_path, '.*/([^/]+)/[^/]+$')
  local extension = ''
  local file_icon = ''
  local file_icon_color = ''
  local default_file_icon = ''
  local default_file_icon_color = ''

  if not isempty(filename) then
    extension = vim.fn.expand('%:e')

    local default = false

    if isempty(extension) then
      extension = ''
      default = true
    end

    file_icon, file_icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = default })

    local hl_group = 'FileIconColor' .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if file_icon == nil then
      file_icon = default_file_icon
      file_icon_color = default_file_icon_color
    end

    -- Return filename if parent dir doesn't exist
    if parent_dir == nil or parent_dir == '' then
      return ' ' .. '%#' .. hl_group .. '#' .. file_icon .. '%*' .. ' ' .. '%#LineNr#' .. filename .. '%*'
    end

    -- Return parent dir
    return ' ' .. '%#' .. hl_group .. '#' .. file_icon .. '%*' .. ' ' .. '%#LineNr#' .. parent_dir .. '%*'
  end
end

M.gps = function()
  local status_ok, navic_location = pcall(navic.get_location, {})
  if not status_ok then
    return
  end

  if not navic.is_available() then -- Returns boolean value indicating whether a output can be provided
    return
  end

  local retval = M.filename()

  if navic_location == 'error' then
    return ''
  else
    if not isempty(navic_location) then
      local hl_group = 'LineNr'
      return retval .. ' ' .. '%#' .. hl_group .. '#' .. icons.misc.caret_right .. '%*' .. ' ' .. navic_location
    else
      return retval
    end
  end
end

vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufWinEnter', 'BufFilePost' }, {
  callback = function()
    local winbar_filetype_exclude = {
      'help',
      'startify',
      'dashboard',
      'packer',
      'neogitstatus',
      'NvimTree',
      'neo-tree',
      'Trouble',
      'alpha',
      'lir',
      'Outline',
      'spectre_panel',
      'TelescopePrompt',
      'DressingInput',
      'DressingSelect',
      'neotest-summary',
      'toggleterm',
      'octo',
    }

    if vim.api.nvim_win_get_config(0).relative ~= '' then
      return
    end

    if vim.bo.filetype == 'dapui_watches' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.misc.clock .. 'Watches' .. '%*'
      return
    end

    if vim.bo.filetype == 'dapui_stacks' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.git.symbol .. 'Stacks' .. '%*'
      return
    end

    if vim.bo.filetype == 'dapui_breakpoints' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.misc.circle .. 'Breakpoints' .. '%*'
      return
    end

    if vim.bo.filetype == 'dapui_scopes' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.misc.telescope .. 'Scopes' .. '%*'
      return
    end

    if vim.bo.filetype == 'dap-repl' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.misc.console_debug .. 'Debug Console' .. '%*'
      return
    end

    if vim.bo.filetype == 'dapui_console' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.misc.mode_term .. 'Console' .. '%*'
      return
    end

    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar = nil
      return
    end

    if vim.bo.filetype == 'GitBlame' then
      local hl_group = 'CursorLineNR'
      vim.opt_local.winbar = ' ' .. '%#' .. hl_group .. '#' .. icons.git.symbol .. 'Blame' .. '%*'
      return
    end

    local winbar_present, winbar = pcall(require, 'core.winbar')
    if not winbar_present or type(winbar) == 'boolean' then
      vim.opt_local.winbar = nil
      return
    end

    local value = winbar.gps()

    if value == nil then
      value = winbar.filename()
    end

    vim.opt_local.winbar = value
  end,
})

return M
