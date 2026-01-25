local wezterm = require("wezterm")
local nerdfonts = wezterm.nerdfonts
local colors = require("utils.colors")

-- 	cod_circle_filled
-- 	cod_circle_large_filled
-- 	fa_circle
-- 	fa_hand_stop_o
-- 	oct_file_moved
-- 	cod_move
-- 󰆾	md_cursor_move
-- 	oct_copy
-- 󰝰	md_folder_open
-- 󰷏	md_folder_open_outline
-- 󰍉	md_magnify
-- 󱅫	md_bell_badge
-- 󰘳	md_apple_keyboard_command
-- 󰊠	md_ghost
-- 	ple_trapezoid_top_bottom
-- 	ple_trapezoid_top_bottom_mirrored
-- 
-- 
-- 
-- 
-- 	ple_lower_left_triangle
-- 	ple_lower_right_triangle

local M = {}

-- Status section component
local function create_section(icon, text, bg_color, fg_color)
	fg_color = fg_color or colors.bg()

	return {
		{ Text = " " },
		{ Background = { Color = colors.bg() } },
		{ Foreground = { Color = bg_color } },
		{ Text = nerdfonts.ple_left_half_circle_thick },
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Text = icon .. " " },
		{ Background = { Color = colors.cursor() } },
		{ Foreground = { Color = colors.bg() } },
		{ Text = " " .. text },
		{ Background = { Color = colors.bg() } },
		{ Foreground = { Color = colors.cursor() } },
		{ Text = nerdfonts.ple_right_half_circle_thick },
	}
end

function M.create_left_status(stat, workspace_color)
	return wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = colors.bg() } },
		{ Text = " " },
		{ Foreground = { Color = workspace_color } },
		{ Text = nerdfonts.ple_left_half_circle_thick },
		{ Background = { Color = workspace_color } },
		{ Foreground = { Color = colors.bright_black() } },
		{ Text = nerdfonts.cod_terminal_tmux .. " " },
		{ Background = { Color = colors.bright_black() } },
		{ Foreground = { Color = workspace_color } },
		{ Text = " " .. stat .. " " },
		{ Background = { Color = colors.bg() } },
		{ Foreground = { Color = colors.bright_black() } },
		{ Text = nerdfonts.ple_right_half_circle_thick .. " " },
	})
end

function M.create_right_status(cwd, username, hostname, time)
	local sections = {
		{ icon = nerdfonts.md_folder, text = cwd, color = colors.blue() },
		{ icon = nerdfonts.fa_user, text = username, color = colors.cyan() },
		{ icon = nerdfonts.dev_apple, text = hostname, color = colors.magenta() },
		{ icon = nerdfonts.md_calendar_clock, text = time, color = colors.bright_black() },
	}

	local formatted = {}
	for _, section in ipairs(sections) do
		local section_format = create_section(section.icon, section.text, section.color)
		for _, item in ipairs(section_format) do
			table.insert(formatted, item)
		end
	end

	return wezterm.format(formatted)
end

return M
