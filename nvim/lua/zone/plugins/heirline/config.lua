local icons = require('zone.theme.icons')
local heirline_utils = require('heirline.utils')
local conditions = require('heirline.conditions')
local colors = require('zone.plugins.heirline.components.colors')
local vi_mode = require('zone.plugins.heirline.components.mode')
local utils = require('zone.plugins.heirline.utils')
local scroll_bar = require('zone.plugins.heirline.components.scroll_bar')
local file_block = require('zone.plugins.heirline.components.file_block')
local file_size = require('zone.plugins.heirline.components.file_size')
local ruler = require('zone.plugins.heirline.components.ruler')
local lsp = require('zone.lsp.statusline')
local git = require('zone.plugins.heirline.components.git')
local diagnostics = require('zone.plugins.heirline.components.diagnostics')

local space = { provider = ' ' }
local spring = { provider = '%=' }
--local null = { provider = '' }

-- {{ LEFT SECTION
local left_slant = {
  provider = icons.separators.block .. icons.separators.slant_right .. ' ',
  hl = utils.vi_mode_hl(),
}

local code_actions = {
  provider = lsp.code_actions,
}
-- }}

-- {{ MIDDLE SECTION
local lsp_progress = {
  provider = lsp.status_progress,
}
-- }}

-- {{ RIGHT SECTION
local lsp_clients_running = {
  conditions = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = lsp.status_clients('running'),
  hl = { fg = colors.green },
}

local lsp_clients_starting = {
  conditions = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = lsp.status_clients('starting'),
  hl = { fg = colors.diag_info },
}

local lsp_clients_exited_ok = {
  conditions = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = lsp.status_clients('exited_ok'),
  hl = { fg = colors.gray },
}

local lsp_clients_exited_error = {
  conditions = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = lsp.status_clients('exited_err'),
  hl = { fg = colors.diag_error },
}

local right_slant = {
  provider = ' ' .. icons.separators.slant_left .. icons.separators.block,
  hl = utils.vi_mode_hl(),
}
-- }}
--

local file_info = heirline_utils.surround(
  { icons.separators.slant_left_2 .. icons.separators.block, icons.separators.block .. icons.separators.slant_right_2 },
  colors.statusline_bg,
  file_block
)

local left_slant_2 = {
  provider = ' ' .. icons.separators.slant_left_2_thin,
  hl = { fg = colors.text },
}
local right_slant_2 = {
  provider = ' ' .. icons.separators.slant_right_2_thin,
  hl = { fg = colors.text },
}

local left_section = {
  left_slant,
  vi_mode,
  space,
  file_info,
  space,
  file_size,
  left_slant_2,
  ruler,
  right_slant_2,
  code_actions,
  space,
  diagnostics,
}

local middle_section = {
  lsp_progress,
}

local right_section = {
  lsp_clients_running,
  space,
  lsp_clients_starting,
  space,
  lsp_clients_exited_ok,
  space,
  lsp_clients_exited_error,
  space,
  git,
  space,
  scroll_bar,
  right_slant,
}

local active_status_line = {
  --{{{
  condition = conditions.is_active,
  hl = {
    fg = colors.text,
    bg = colors.bg,
  },
  left_section,
  spring,
  middle_section,
  spring,
  right_section,
} --}}}

local status_line = {
  --{{{
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(self.filename, ':e')
    self.icon, self.icon_color =
        require('nvim-web-devicons').get_icon_color(self.filename, extension, { default = true })
    self.mode = vim.fn.mode()
  end,
  stop_when = function(_, out)
    return out ~= ''
  end,
  --help_file_name,
  --disabled_buffers,
  active_status_line,
  --inactive_status_line,
} --}}}

require('heirline').load_colors(colors)
require('heirline').setup({
  statusline = status_line,
})
