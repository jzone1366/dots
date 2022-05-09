local feline = require 'feline'
local lsp = require 'feline.providers.lsp'

local cnf = require('chalklines.config').get()
local p = cnf.palette

local file_info = require 'zone.statusline.file_info'

require 'zone.statusline.lsp'
--require 'zone.statusline.dap'

local utils = require 'zone.utils'

--@TODO: Update to put in with theme.icons
local separators = {
  vertical_bar = '┃',
  vertical_bar_thin = '│',
  left = '',
  right = '',
  block = '█',
  left_filled = '',
  right_filled = '',
  slant_left = '',
  slant_left_thin = '',
  slant_right = '',
  slant_right_thin = '',
  slant_left_2 = '',
  slant_left_2_thin = '',
  slant_right_2 = '',
  slant_right_2_thin = '',
  left_rounded = '',
  left_rounded_thin = '',
  right_rounded = '',
  right_rounded_thin = '',
  circle = '●',
  moon = '',
  heart = '♥ ',
  ghost = ' ',
  code = '',
}

local sett = {
  bkg = p.base,
  diffs = p.orange,
  extras = p.subtle,
  curr_file = p.cyan,
  curr_dir = p.magenta,
}

local vi_mode_colors = {
  ['n'] = { 'NORMAL', p.cyan },
  ['no'] = { 'N-PENDING', p.cyan },
  ['i'] = { 'INSERT', p.green },
  ['ic'] = { 'INSERT', p.green },
  ['t'] = { 'TERMINAL', p.green },
  ['v'] = { 'VISUAL', p.magenta },
  ['V'] = { 'V-LINE', p.magenta },
  [''] = { 'V-BLOCK', p.magenta },
  ['R'] = { 'REPLACE', p.surface },
  ['Rv'] = { 'V-REPLACE', p.surface },
  ['s'] = { 'SELECT', p.surface },
  ['S'] = { 'S-LINE', p.surface },
  [''] = { 'S-BLOCK', p.surface },
  ['c'] = { 'COMMAND', p.orange },
  ['cv'] = { 'COMMAND', p.orange },
  ['ce'] = { 'COMMAND', p.orange },
  ['r'] = { 'PROMPT', p.blue },
  ['rm'] = { 'MORE', p.blue },
  ['r?'] = { 'CONFIRM', p.yellow },
  ['!'] = { 'SHELL', p.green },
}

local filetypes_override_name = {
  'NvimTree',
  aerial = 'Aerial',
}

local config = {
  preset = 'default',

  separators = separators,

  force_inactive = {
    filetypes = utils.tbl_listkeys(filetypes_override_name),
    buftypes = {
      'terminal',
      'nofile',
    },
    bufnames = {},
  },

  components = {
    active = {},
    inactive = {},
  },

  custom_providers = require('zone.statusline.providers').providers,
}

local vi_mode_hl = function(hl)
  return function()
    local _hl = hl
    if _hl then
      _hl = vim.deepcopy(_hl)
    else
      _hl = { fg = true }
    end

    local color = vi_mode_colors[vim.fn.mode()][2] or p.fg

    if _hl.fg == true then
      _hl.fg = color
    end
    if _hl.bg == true then
      _hl.bg = color
    end
    return _hl
  end
end

config.components.active[1] = {
  {
    provider = separators.block .. separators.slant_right .. ' ',
    hl = vi_mode_hl(),
  },
  {
    provider = separators.ghost,
    hl = vi_mode_hl { fg = true, style = 'bold' },
  },
  {
    provider = {
      name = 'zone_file_info',
      opts = {
        active = true,
        filetypes_override_name = filetypes_override_name,
      },
    },
    hl = file_info.hl {
      fg = p.fg,
      bg = p.hl_med,
      style = 'bold',
    },
    left_sep = {
      { str = 'slant_left_2', hl = { fg = p.hl_med } },
      { str = ' ', hl = { bg = p.hl_med } },
    },
    right_sep = {
      { str = 'slant_right_2', hl = { fg = p.hl_med } },
    },
  },
  {
    provider = 'file_size',
    enabled = function()
      return vim.fn.getfsize(vim.fn.expand '%:p') > 0
    end,
    left_sep = ' ',
    right_sep = {
      { str = ' ' },
      { str = 'slant_left_2_thin', hl = { fg = p.fg } },
    },
  },
  {
    provider = 'position',
    left_sep = ' ',
    right_sep = {
      { str = ' ' },
      { str = 'slant_right_2_thin', hl = { fg = p.fg } },
    },
  },
  {
    provider = config.custom_providers.lsp_code_actions,
    hl = { fg = p.green },
  },
  {
    provider = 'diagnostic_errors',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
    end,
    hl = { fg = p.red },
  },
  {
    provider = 'diagnostic_warnings',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
    end,
    hl = { fg = p.yellow },
  },
  {
    provider = 'diagnostic_hints',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
    end,
    hl = { fg = p.magenta },
  },
  {
    provider = 'diagnostic_info',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
    end,
    hl = { fg = p.blue },
  },
}

config.components.active[2] = {
  {
    provider = 'lsp_progress',
    hl = { fg = p.subtle, bold = false },
  },
}

config.components.active[3] = {
  {
    --provider = 'dap_clients',
    provdier = ' ',
    hl = { fg = p.green },
    right_sep = ' ',
  },
  {
    provider = config.custom_providers.lsp_clients_running,
    hl = { fg = p.green },
    right_sep = ' ',
  },
  {
    provider = 'lsp_clients_starting',
    hl = { fg = p.blue },
    right_sep = ' ',
  },
  {
    provider = 'lsp_clients_exited_ok',
    hl = { fg = p.hl_high },
    right_sep = ' ',
  },
  {
    provider = 'lsp_clients_exited_err',
    hl = { fg = p.red },
    right_sep = ' ',
  },
  {
    provider = 'git_branch',
    hl = {
      fg = p.subtle,
      style = 'bold',
    },
    right_sep = ' ',
    left_sep = ' ',
  },
  {
    provider = 'git_diff_added',
    hl = {
      fg = p.green,
    },
  },
  {
    provider = 'git_diff_changed',
    hl = {
      fg = p.orange,
    },
  },
  {
    provider = 'git_diff_removed',
    hl = {
      fg = p.red,
    },
    right_sep = ' ',
  },
  {
    provider = 'line_percentage',
    hl = {
      style = 'bold',
    },
    right_sep = ' ',
    left_sep = ' ',
  },
  {
    provider = 'scroll_bar',
    hl = {
      fg = p.blue,
      style = 'bold',
    },
  },
  {
    provider = ' ' .. separators.slant_left .. separators.block,
    hl = vi_mode_hl(),
  },
}

local hl_if_focused = function(hl_if_true, hl_if_false)
  return function(...)
    local cw = vim.api.nvim_get_current_win()
    local acw = tonumber(vim.g.actual_curwin)
    local hl = cw == acw and hl_if_true or hl_if_false
    if type(hl) == 'function' then
      return hl(...)
    end
    return hl
  end
end

config.components.inactive[1] = {
  {
    provider = separators.block .. separators.slant_right,
    hl = hl_if_focused(
      vi_mode_hl {
        fg = true,
        bg = sett.bkg,
      },
      {
        fg = p.hl_low,
        bg = sett.bkg,
      }
    ),
  },
  {
    provider = function()
      local icon = '  '
      local recents = require('zone.utils.recent-wins').tabpage_get_recents()
      if recents and #recents >= 2 then
        local winid = vim.api.nvim_get_current_win()
        local index = -1
        for i, w in ipairs(recents) do
          if w == winid then
            index = i
            break
          end
        end
        if recents[1] == tonumber(vim.g.actual_curwin) and index == 2 then
          index = 1
        end
        icon = ({ ' ', ' ' })[index] or '  '
      end
      return icon
    end,
    hl = hl_if_focused({
      fg = p.hl_low,
      bg = sett.bkg,
    }, {
      fg = p.hl_low,
      bg = sett.bkg,
    }),
  },
  {
    provider = {
      name = 'zone_file_info',
      opts = {
        active = false,
        filetypes_override_name = filetypes_override_name,
      },
    },
    hl = file_info.hl {
      fg = p.subtle,
      bg = p.hl_low,
    },
    left_sep = {
      {
        str = ' ' .. separators.slant_left_2,
        hl = hl_if_focused({
          bg = sett.bkg,
          fg = p.hl_low,
        }, {
          fg = p.hl_low,
          bg = sett.bkg,
        }),
      },
      { str = ' ', hl = { bg = p.hl_low, fg = 'NONE' } },
    },
    right_sep = {
      {
        str = separators.slant_right_2 .. ' ',
        hl = hl_if_focused({
          fg = p.hl_low,
          bg = sett.bkg,
        }, {
          fg = p.hl_low,
          bg = sett.bkg,
        }),
      },
    },
  },
}
config.components.inactive[2] = {
  {
    provider = ' ',
    hl = hl_if_focused({
      bg = sett.bkg,
    }, {
      bg = sett.bkg,
    }),
  },
}

config.components.inactive[3] = {
  {
    provider = ' ' .. separators.slant_left .. separators.block,
    hl = hl_if_focused(
      vi_mode_hl {
        fg = true,
        bg = sett.bkg,
      },
      {
        fg = p.hl_low,
        bg = sett.bkg,
      }
    ),
  },
}

feline.setup(config)
--vim.o.laststatus = 3
