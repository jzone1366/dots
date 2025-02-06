local M = {}

M.mocha = {
	black = "#45475a",
	red = "#f38ba8",
	green = "#a6e3a1",
	yellow = "#f9e2af",
	blue = "#89b4fa",
	magenta = "#f5c2e7",
	cyan = "#94e2d5",
	white = "#bac2de",

	bright_black = "#585b70",
	bright_red = "#f38ba8",
	bright_green = "#a6e3a1",
	bright_yellow = "#f9e2af",
	bright_blue = "#89b4fa",
	bright_magenta = "#f5c2e7",
	bright_cyan = "#94e2d5",
	bright_white = "#a6adc8",

	background = "#1e1e2e",
	foreground = "#cdd6f4",
}

M.latte = {
	black = "#5c5f77",
	red = "#d20f39",
	green = "#40a02b",
	yellow = "#df8e1d",
	blue = "#1e66f5",
	magenta = "#ea76cb",
	cyan = "#179299",
	white = "#acb0be",

	bright_black = "#6c6f85",
	bright_red = "#d20f39",
	bright_green = "#40a02b",
	bright_yellow = "#df8e1d",
	bright_blue = "#1e66f5",
	bright_magenta = "#ea76cb",
	bright_cyan = "#179299",
	bright_white = "#bcc0cc",

	background = "#eff1f5",
	foreground = "#4c4f69",
}

M.palette_mocha = {
	ansi = {
		M.mocha.black,
		M.mocha.red,
		M.mocha.green,
		M.mocha.yellow,
		M.mocha.blue,
		M.mocha.magenta,
		M.mocha.cyan,
		M.mocha.white,
	},
	brights = {
		M.mocha.bright_black,
		M.mocha.bright_red,
		M.mocha.bright_green,
		M.mocha.bright_yellow,
		M.mocha.bright_blue,
		M.mocha.bright_magenta,
		M.mocha.bright_cyan,
		M.mocha.bright_white,
	},
	indexed = {},
	background = M.mocha.background,
	foreground = M.mocha.foreground,
	cursor_bg = M.mocha.foreground,
	cursor_border = M.mocha.foreground,
	cursor_fg = M.mocha.background,
	tab_bar = {
		inactive_tab_edge = M.mocha.foreground,
		background = M.mocha.background,
		active_tab = {
			bg_color = M.mocha.black,
			fg_color = M.mocha.foreground,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = M.mocha.background,
			fg_color = M.mocha.foreground,
			intensity = "Half",
		},
		new_tab = {
			bg_color = M.mocha.foreground,
			fg_color = M.mocha.background,
		},
	},
}

M.palette_latte = {
	ansi = {
		M.latte.black,
		M.latte.red,
		M.latte.green,
		M.latte.yellow,
		M.latte.blue,
		M.latte.magenta,
		M.latte.cyan,
		M.latte.white,
	},
	brights = {
		M.latte.bright_black,
		M.latte.bright_red,
		M.latte.bright_green,
		M.latte.bright_yellow,
		M.latte.bright_blue,
		M.latte.bright_magenta,
		M.latte.bright_cyan,
		M.latte.bright_white,
	},
	indexed = {},
	background = M.latte.background,
	foreground = M.latte.foreground,
	cursor_bg = M.latte.foreground,
	cursor_border = M.latte.foreground,
	cursor_fg = M.latte.background,
	tab_bar = {
		inactive_tab_edge = M.latte.foreground,
		background = M.latte.background,
		active_tab = {
			bg_color = M.latte.black,
			fg_color = M.latte.foreground,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = M.latte.background,
			fg_color = M.latte.foreground,
			intensity = "Half",
		},
		new_tab = {
			bg_color = M.latte.foreground,
			fg_color = M.latte.background,
		},
	},
}

return M
