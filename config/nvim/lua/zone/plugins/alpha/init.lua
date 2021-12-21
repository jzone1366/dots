local icons = require('zone.theme.icons')
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '███████╗ ██████╗ ███╗   ██╗███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗',
  '╚══███╔╝██╔═══██╗████╗  ██║██╔════╝████╗  ██║██║   ██║██║████╗ ████║',
  '  ███╔╝ ██║   ██║██╔██╗ ██║█████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║',
  ' ███╔╝  ██║   ██║██║╚██╗██║██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
  '███████╗╚██████╔╝██║ ╚████║███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
  '╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
  '',
  '',
  '',
}

dashboard.section.buttons.val = {
  dashboard.button('<leader>ff', icons.file1 .. ' Find File', '<Cmd>Telescope find_files<CR>'),
  dashboard.button('<C-n>', icons.file2 .. ' Find Manager', '<Cmd>NvimTreeToggle<CR>'),
  dashboard.button('<leader>fs', icons.word .. ' Grep String', '<Cmd>Telescope grep_string<CR>'),
  dashboard.button('<leader>sl', icons.clock .. ' Load Session', 'lua vim.cmd(":silent RestoreSession")'),
}

dashboard.section.footer.val = "Keep Calm and Code On."

alpha.setup(dashboard.opts)
