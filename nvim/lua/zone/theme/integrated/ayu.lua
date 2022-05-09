local theme = require('ayu.colors')

local colors = {
  white = theme.fg,
  bg = theme.bg,
  bg_highlight = theme.ui,
  normal = theme.func,
  insert = theme.fg,
  command = theme.special,
  visual = theme.selection_inactive,
  replace = theme.neutral_red,
  diffAdd = theme.vcs_added,
  diffModified = theme.vcs_modified,
  diffDeleted = theme.vcs_removed,
  trace = theme.vcs_modified,
  hint = theme.regexp,
  info = theme.tag,
  error = theme.error,
  warn = theme.warning,
  floatBorder = theme.panel_border,
  selection_caret = theme.selection_active,
}

return colors
