local wezterm = require("wezterm")
--local chalklines = require("colors.Chalklines")

--local function merge(t1, t2)
--	for k, v in pairs(t2) do
--		t1[k] = v
--	end
--
--	return t1
--end

local default_opts = {
	color_scheme = "Catppuccin Mocha",
	--font = wezterm.font("JetBrainsMono Nerd Font"),
	font = wezterm.font("Iosevka Nerd Font Mono"),
	--font = wezterm.font("CaskaydiaCove Nerd Font"),
	--font = wezterm.font("GoMono Nerd Font"),
	--font = wezterm.font("FiraCode Nerd Font"),
	--font = wezterm.font("Hack Nerd Font"),
	font_size = 14,
	hide_tab_bar_if_only_one_tab = true,
	default_cursor_style = "SteadyBar",
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	line_height = 1.0,
}

--local opts = merge(default_opts, chalklines)
local opts = default_opts

return opts
