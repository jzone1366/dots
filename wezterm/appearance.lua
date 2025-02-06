local wezterm = require("wezterm")
local catppuccin = require("palettes.catppuccin")
--local evergarden = require("palettes.evergarden")

local M = {}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha" -- dark
	else
		return "Catppuccin Latte" -- light
	end
end

local function window_frame_for_appearance(appearance)
	local window_frame = {
		font = wezterm.font({ family = "Monaspace Xenon", weight = "Bold" }),
	}

	if appearance:find("Dark") then
		window_frame.active_titlebar_bg = catppuccin.mocha.background
		window_frame.inactive_titlebar_bg = catppuccin.mocha.background
	else
		window_frame.active_titlebar_bg = catppuccin.latte.background
		window_frame.inactive_titlebar_bg = catppuccin.latte.background
	end

	return window_frame
end

local function colors_for_appearance(appearance)
	if appearance:find("Dark") then
		return catppuccin.palette_mocha
	else
		return catppuccin.palette_latte
	end
end

function M.apply_to_config(config)
	local appearance = wezterm.gui.get_appearance()
	config.color_scheme = scheme_for_appearance(appearance)
	config.window_frame = window_frame_for_appearance(appearance)
	config.colors = colors_for_appearance(appearance)

	-- Uncomment this block to use the Evergarden theme
	--config.color_scheme = "EvergardenHard"
	--config.window_frame = evergarden.window_frame
	--config.colors = evergarden.palette
end

return M
