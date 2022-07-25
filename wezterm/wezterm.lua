local wezterm = require("wezterm")
local chalklines = require("colors.Chalklines")

local function merge(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end

	return t1
end

local default_opts = {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	--font = wezterm.font("CaskaydiaCove Nerd Font"),
	--font = wezterm.font("GoMono Nerd Font"),
	--font = wezterm.font("FiraCode Nerd Font"),
	--font = wezterm.font("Hack Nerd Font"),
	font_size = 13,

	hide_tab_bar_if_only_one_tab = true,

	default_cursor_style = "SteadyBar",

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	line_height = 1.0,
}

local opts = merge(default_opts, chalklines)

return opts
