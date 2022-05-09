-- Pastel-Paper Wezterm Colors
-- Style: chalklines_dark
-- Upstream: https://github.com/jzone1366/chalklines.nvim/raw/main/extra/dark/chalklines_dark_wezterm.lua
return {
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#FCF7F8",
		background = "#030203",

		cursor_bg = "#FFEBFF",
		cursor_border = "#FFEBFF",
		cursor_fg = "#030203",

		selection_bg = "#4A4748",
		selection_fg = "#FCF7F8",

		ansi = { "#5C595C", "#BF3F50", "#5CAB7D", "#FCD772", "#577FA1", "#ED7782", "#71B3D9", "#807D7D" },
		brights = { "#6E6A6A", "#BF3F50", "#5CAB7D", "#FCD772", "#577FA1", "#ED7782", "#71B3D9", "#FCF7F8" },

		indexed = { [16] = "#DE8B61", [17] = "#FFEBFF" },

		scrollbar_thumb = "#4A4748",
		split = "#262526",

		tab_bar = {
			background = "#030203",
			active_tab = {
				bg_color = "#262526",
				fg_color = "#FFEBFF",
			},
			inactive_tab = {
				bg_color = "#030203",
				fg_color = "#FCF7F8",
			},
			inactive_tab_hover = {
				bg_color = "#262526",
				fg_color = "#FCF7F8",
			},
			new_tab = {
				bg_color = "#141414",
				fg_color = "#5C595C",
			},
			new_tab_hover = {
				bg_color = "#262526",
				fg_color = "#FCF7F8",
				italic = true,
			},
		},

		visual_bell = "#383638",

		-- nightbuild only
		compose_cursor = "#DE8B61",
	},
}
