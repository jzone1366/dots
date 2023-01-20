---- stevearc/aerial.nvim
local update_delay = 500

require('aerial').setup({
  backends = { 'lsp', 'treesitter', 'markdown' },
  attach_mode = 'global',
  disable_max_lines = 3000,
  filter_kind = {
    'Class',
    'Constructor',
    'Enum',
    'Function',
    'Interface',
    'Module',
    'Method',
    'Struct',
    'Type',
  },
  layout = {
    min_width = 30,
    default_direction = 'right',
    placement = 'edge',
  },
  highlight_on_hover = true,
  ignore = { filetypes = { 'gomod' } },
  update_events = 'TextChanged,InsertLeave',
  lsp = {
    update_when_errors = true,
    diagnostics_trigger_update = true,
    update_delay = update_delay,
  },
  treesitter = {
    update_delay = update_delay,
  },
  markdown = {
    update_delay = update_delay,
  },
})
