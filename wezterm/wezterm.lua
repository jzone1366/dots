local wezterm = require("wezterm")
local kanagawa = require("colors/kanagawa")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha" -- dark
	else
		return "Catppuccin Latte" -- light
	end
end

local function colors_for_appearance(appearance)
	if appearance:find("Dark") then
		return kanagawa.dragon
	else
		return kanagawa.lotus
	end
end

local config = {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	force_reverse_video_cursor = true,

	-- Now I can use an unpatched font and have a fallback for the symbols.
	font = wezterm.font_with_fallback({
		"Monaspace Xenon",
		"Symbols Nerd Font",
	}),

	font_size = 16,
	hide_tab_bar_if_only_one_tab = true,
	default_cursor_style = "SteadyBar",
	window_decorations = "RESIZE|TITLE",

	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
}

--config.colors = colors_for_appearance(wezterm.gui.get_appearance())

return config
