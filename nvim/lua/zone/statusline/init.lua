local feline = require('feline')
local lsp = require('feline.providers.lsp')

local p = require('chalklines').get_colors(vim.g.chalklines_theme)

local file_info = require('zone.statusline.file_info')

require('zone.statusline.lsp')
--require 'zone.statusline.dap'

print(vim.inspect(vim.bo.filetype))

local utils = require('zone.utils')

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

local vi_mode_colors = {
  ['n'] = { 'NORMAL', p.green },
  ['no'] = { 'N-PENDING', p.green },
  ['i'] = { 'INSERT', p.blue },
  ['ic'] = { 'INSERT', p.blue },
  ['t'] = { 'TERMINAL', p.green },
  ['v'] = { 'VISUAL', p.purple },
  ['V'] = { 'V-LINE', p.purple },
  [''] = { 'V-BLOCK', p.purple },
  ['R'] = { 'REPLACE', p.cyan },
  ['Rv'] = { 'V-REPLACE', p.cyan },
  ['s'] = { 'SELECT', p.cyan },
  ['S'] = { 'S-LINE', p.cyan },
  [''] = { 'S-BLOCK', p.cyan },
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
  alpha = 'Alpha',
}

local config = {
  separators = separators,
  force_inactive = {
    filetypes = {
      '^NvimTree$',
      '^packer$',
      '^startify$',
      '^alpha$',
      '^fugitive$',
      '^fugitiveblame$',
      '^qf$',
      '^help$',
      '^aerial$',
    },
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
      _hl.bg = p.bg
    end
    if _hl.bg == true then
      _hl.bg = color
      _hl.fg = p.bg
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
    hl = vi_mode_hl({ fg = true, style = 'bold' }),
  },
  {
    provider = {
      name = 'zone_file_info',
      opts = {
        active = true,
        filetypes_override_name = filetypes_override_name,
      },
    },
    hl = file_info.hl({
      fg = p.fg,
      bg = p.cursorline,
      style = 'bold',
    }),
    left_sep = {
      { str = 'slant_left_2', hl = { fg = p.cursorline, bg = p.bg } },
      { str = ' ', hl = { fg = p.bg, bg = p.cursorline } },
    },
    right_sep = {
      { str = 'slant_right_2', hl = { fg = p.cursorline, bg = p.bg } },
    },
  },
  {
    provider = 'file_size',
    hl = { fg = p.fg, bg = p.bg },
    enabled = function()
      return vim.fn.getfsize(vim.fn.expand('%:p')) > 0
    end,
    left_sep = {
      str = ' ',
      hl = { fg = p.fg, bg = p.bg },
    },
    right_sep = {
      { str = ' ', hl = { fg = p.bg, bg = p.bg } },
      { str = 'slant_left_2_thin', hl = { fg = p.fg, bg = p.bg } },
    },
  },
  {
    provider = 'position',
    hl = { fg = p.fg, bg = p.bg },
    left_sep = {
      str = ' ',
      hl = { fg = p.fg, bg = p.bg },
    },
    right_sep = {
      { str = ' ', hl = { fg = p.bg, bg = p.bg } },
      { str = 'slant_right_2_thin', hl = { fg = p.fg, bg = p.bg } },
    },
  },
  {
    provider = config.custom_providers.lsp_code_actions,
    hl = { fg = p.red, bg = p.bg },
  },
  {
    provider = 'diagnostic_errors',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
    end,
    hl = { fg = p.red, bg = p.bg },
  },
  {
    provider = 'diagnostic_warnings',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
    end,
    hl = { fg = p.yellow, bg = p.bg },
  },
  {
    provider = 'diagnostic_hints',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
    end,
    hl = { fg = p.purple, bg = p.bg },
  },
  {
    provider = 'diagnostic_info',
    enabled = function()
      return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
    end,
    hl = { fg = p.blue, bg = p.bg },
  },
}

config.components.active[2] = {
  {
    provider = 'lsp_progress',
    hl = { fg = p.fg, bg = p.bg, bold = false },
  },
}

config.components.active[3] = {
  {
    provider = config.custom_providers.lsp_clients_running,
    hl = { fg = p.green, bg = p.bg },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'lsp_clients_starting',
    hl = { fg = p.blue, bg = p.bg },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'lsp_clients_exited_ok',
    hl = { fg = p.cursorline, bg = p.bg },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'lsp_clients_exited_err',
    hl = { fg = p.red, bg = p.bg },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'git_branch',
    hl = {
      fg = p.fg_gutter,
      bg = p.bg,
      style = 'bold',
    },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
    left_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'git_diff_added',
    hl = {
      fg = p.diff_add,
      bg = p.bg,
    },
  },
  {
    provider = 'git_diff_changed',
    hl = {
      fg = p.orange,
      bg = p.bg,
    },
  },
  {
    provider = 'git_diff_removed',
    hl = {
      fg = p.diff_delete,
      bg = p.bg,
    },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  {
    provider = 'line_percentage',
    hl = {
      fg = p.fg,
      bg = p.bg,
      style = 'bold',
    },
    right_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
    left_sep = {
      str = ' ',
      hl = { fg = p.bg, bg = p.bg },
    },
  },
  --  {
  --    provider = 'scroll_bar',
  --    hl = {
  --      fg = p.blue,
  --      bg = p.bg,
  --      style = 'bold',
  --    },
  --  },
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
      vi_mode_hl({
        fg = true,
        bg = p.bg,
      }),
      {
        fg = p.cursorline,
        bg = p.bg,
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
      fg = p.cursorline,
      bg = p.bg,
    }, {
      fg = p.cursorline,
      bg = p.bg,
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
    hl = file_info.hl({
      fg = p.fg,
      bg = p.cursorline,
    }),
    left_sep = {
      {
        str = ' ' .. separators.slant_left_2,
        hl = hl_if_focused({
          bg = p.bg,
          fg = p.cursorline,
        }, {
          fg = p.cursorline,
          bg = p.bg,
        }),
      },
      { str = ' ', hl = { bg = p.cursorline, fg = 'NONE' } },
    },
    right_sep = {
      {
        str = separators.slant_right_2 .. ' ',
        hl = hl_if_focused({
          fg = p.cursorline,
          bg = p.bg,
        }, {
          fg = p.cursorline,
          bg = p.bg,
        }),
      },
    },
  },
}
config.components.inactive[2] = {
  {
    provider = ' ',
    hl = hl_if_focused({
      fg = 'NONE',
      bg = p.bg,
    }, {
      fg = 'NONE',
      bg = p.bg,
    }),
  },
}

config.components.inactive[3] = {
  {
    provider = ' ' .. separators.slant_left .. separators.block,
    hl = hl_if_focused(
      vi_mode_hl({
        fg = true,
        bg = p.bg,
      }),
      {
        fg = p.cursorline,
        bg = p.bg,
      }
    ),
  },
}

feline.setup(config)
