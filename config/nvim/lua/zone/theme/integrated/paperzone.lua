local theme = require('paperzone.colors')

local colors = {
  white = theme.white,
  bg = theme.bg,
  bg_highlight = theme.sidebar_bg_alt,
  normal = theme.teal,
  insert = theme.green,
  command = theme.darkorange,
  visual = theme.purple,
  replace = theme.magenta,
  diffAdd = theme.git_added,
  diffModified = theme.git_modified,
  diffDeleted = theme.git_removed,
  trace = theme.purple,
  hint = theme.hint_fg,
  info = theme.info_fg,
  error = theme.error_fg,
  warn = theme.warn_fg,
  floatBorder = theme.border,
  selection_caret = theme.purple,
}

return colors
