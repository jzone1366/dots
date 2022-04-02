return {
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#FCF7F8",
		background = "#070A0E",

		cursor_bg = "#FFEBFF",
		cursor_border = "#FFEBFF",
		cursor_fg = "#070A0E",

		selection_bg = "#181E24",
		selection_fg = "#FCF7F8",

		ansi = { "#21282F", "#BF3F50", "#5CAB7D", "#FCD772", "#577FA1", "#ED7782", "#71B3D9", "#3A4650" },
		brights = { "#29323A", "#BF3F50", "#5CAB7D", "#FCD772", "577FA1", "#ED7782", "#71B3D9", "#FCF7F8" },

		indexed = { [16] = "#DE8B61", [17] = "#FFEBFF" },

		scrollbar_thumb = "#181E24",
		split = "#040507",

		tab_bar = {
			background = "#070A0E",
			active_tab = {
				bg_color = "#181E24",
				fg_color = "#FFEBFF",
			},
			inactive_tab = {
				bg_color = "#070A0E",
				fg_color = "#FCF7F8",
			},
			inactive_tab_hover = {
				bg_color = "#181E24",
				fg_color = "#FCF7F8",
			},
			new_tab = {
				bg_color = "#06080B",
				fg_color = "#21282F",
			},
			new_tab_hover = {
				bg_color = "#181E24",
				fg_color = "#FCF7F8",
				italic = true,
			},
		},

		visual_bell = "#101419",

		-- nightbuild only
		compose_cursor = "#DE8B61",
	},
}
