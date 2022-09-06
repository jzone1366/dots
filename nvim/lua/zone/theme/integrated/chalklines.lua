local theme = require('chalklines').get_colors(vim.g.chalklines_theme)

local colors = {
  white = theme.white,
  bg = theme.bg,
  bg_highlight = theme.highlight,
  normal = theme.green,
  insert = theme.blue,
  command = theme.yellow,
  visual = theme.purple,
  replace = theme.cyan,
  diffAdd = theme.diff_add,
  diffModified = theme.orange,
  diffDeleted = theme.diff_delete,
  trace = theme.cyan,
  hint = theme.green,
  info = theme.blue,
  error = theme.red,
  warn = theme.cyan,
  floatBorder = theme.cyan,
  selection_caret = theme.purple,
}

return colors
