local theme = require("chalklines.core.palettes").init()

local colors = {
	white = theme.white,
	bg = theme.bg,
	bg_highlight = theme.bg_highlight,
	normal = theme.maroon,
	insert = theme.pink,
	command = theme.red,
	visual = theme.yellow,
	replace = theme.magenta,
	diffAdd = theme.blue,
	diffModified = theme.teal,
	diffDeleted = theme.red,
	trace = theme.red,
	hint = theme.white,
	info = theme.teal,
	error = theme.magenta,
	warn = theme.red,
	floatBorder = theme.background_dark,
	selection_caret = theme.maroon,
}

return colors
