local icons = require('zone.theme.icons')
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local headers = require('zone.plugins.alpha.headers')
local fn = vim.fn

-- Top Percent
local marginTopPercent = 0.15
local topPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

-- Middle Percent
local marginMiddlePercent = 0.1
local middlePadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginMiddlePercent) })

dashboard.config.layout = {
  { type = 'padding', val = topPadding },
  dashboard.section.header,
  { type = 'padding', val = middlePadding },
  dashboard.section.buttons,
  dashboard.section.footer,
}
dashboard.section.header.val = headers.random()

dashboard.section.buttons.val = {
  dashboard.button(
    '<leader>ff',
    icons.file1 .. ' Find File',
    '<Cmd>lua require("zone.plugins.telescope.mappings").project_files()<CR>'
  ),
  dashboard.button('<C-n>', icons.file2 .. ' Find Manager', '<Cmd>NvimTreeToggle<CR>'),
  dashboard.button('<leader>fs', icons.word .. ' Grep String', '<Cmd>Telescope grep_string<CR>'),
  dashboard.button('<leader>sl', icons.clock .. ' Load Session', 'lua vim.cmd(":silent RestoreSession")'),
}

dashboard.section.footer.val = 'Keep Calm and Code On.'

alpha.setup(dashboard.opts)
