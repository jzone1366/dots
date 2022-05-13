local theme = require('chalklines.palette')

local colors = {
  white = theme.text,
  bg = theme.surface,
  bg_highlight = theme.surface,
  normal = theme.green,
  insert = theme.blue,
  command = theme.yellow,
  visual = theme.magenta,
  replace = theme.cyan,
  diffAdd = theme.blue,
  diffModified = theme.green,
  diffDeleted = theme.cyan,
  trace = theme.cyan,
  hint = theme.green,
  info = theme.blue,
  error = theme.red,
  warn = theme.cyan,
  floatBorder = theme.cyan,
  selection_caret = theme.magenta,
}

return colors
