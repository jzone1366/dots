local icons = require('theme.icons')
local heirline_utils = require('heirline.utils')
local conditions = require('heirline.conditions')
local colors = require('plugins.heirline.components.colors')
local vi_mode = require('plugins.heirline.components.mode')
local utils = require('plugins.heirline.utils')
local scroll_bar = require('plugins.heirline.components.scroll_bar')
local file_block = require('plugins.heirline.components.file_block')
local file_size = require('plugins.heirline.components.file_size')
local ruler = require('plugins.heirline.components.ruler')
local git = require('plugins.heirline.components.git')

local space = { provider = ' ' }
local spring = { provider = '%=' }
--local null = { provider = '' }

-- {{ LEFT SECTION
local left_slant = {
  provider = icons.separators.block .. icons.separators.slant_right .. ' ',
  hl = utils.vi_mode_hl(),
}
-- }}

-- {{ MIDDLE SECTION
-- }}

-- {{ RIGHT SECTION
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
  space,
}

local middle_section = {}

local right_section = {
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
