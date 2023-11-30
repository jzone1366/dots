local icons = require('theme.icons')
local utils = require('utils.theme')

return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    keywords = {
      FIX = {
        icon = icons.debug,                                                -- icon used for the sign, and in search results
        color = 'error',                                                   -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = icons.check, color = 'info' },
      HACK = { icon = icons.flame, color = 'warning' },
      WARN = { icon = icons.warn, color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = icons.perf, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = icons.note, color = 'hint', alt = { 'INFO' } },
    },
    colors = {
      error = { 'DiagnosticError', 'ErrorMsg', utils.get_highlight('DiagnosticError').fg },
      warning = { 'DiagnosticWarn', 'WarningMsg', utils.get_highlight('DiagnosticWarn').fg },
      info = { 'DiagnosticInfo', utils.get_highlight('DiagnosticInfo').fg },
      hint = { 'DiagnosticHint', utils.get_highlight('DiagnosticHint').fg },
      default = { 'Identifier', utils.get_highlight('Statement').fg },
    },
  },
  event = 'VeryLazy',
}
