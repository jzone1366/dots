local wezterm = require("wezterm")

local M = {}

M.colors = {
	text = "#DDDECF",
	subtext1 = "#CACCBE",
	subtext0 = "#94AAA0",
	overlay2 = "#839E9A",
	overlay1 = "#738A8B",
	overlay0 = "#617377",
	surface2 = "#4F5E62",
	surface1 = "#3D494D",
	surface0 = "#313B40",
	base = "#232A2E",
	mantle = "#1C2225",
	crust = "#171C1F",
	softbase = "#2B3538",
	red = "#E67E80",
	orange = "#E69875",
	yellow = "#DBBC7F",
	green = "#B2C98F",
	aqua = "#93C9A1",
	skye = "#97C9C3",
	blue = "#9BB5CF",
	purple = "#D6A0D1",
	pink = "#E3A8D1",
}

M.palette = {
	ansi = {
		M.colors.mantle,
		M.colors.red,
		M.colors.green,
		M.colors.yellow,
		M.colors.blue,
		M.colors.purple,
		M.colors.aqua,
		M.colors.text,
	},
	brights = {
		M.colors.surface0,
		M.colors.red,
		M.colors.green,
		M.colors.yellow,
		M.colors.blue,
		M.colors.purple,
		M.colors.aqua,
		M.colors.subtext0,
	},
	background = M.colors.mantle,
	foreground = M.colors.text,
	cursor_bg = M.colors.orange,
	cursor_border = M.colors.orange,
	cursor_fg = M.colors.crust,
	tab_bar = {
		background = M.colors.mantle,
		active_tab = {
			bg_color = M.colors.mantle,
			fg_color = M.colors.green,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = M.colors.crust,
			fg_color = M.colors.surface2,
			intensity = "Half",
		},
		inactive_tab_edge = M.colors.surface2,
		new_tab = {
			bg_color = M.colors.text,
			fg_color = M.colors.mantle,
		},
	},
}

M.window_frame = {
	font = wezterm.font({ family = "Monaspace Xenon", weight = "Bold" }),
	active_titlebar_bg = M.colors.mantle,
	inactive_titlebar_bg = M.colors.mantle,
}

return M
