local wezterm = require("wezterm")

local M = {}

local themes = {
	dark = "Flexoki Dark",
	light = "Flexoki Light",
}

-- Color cache
local color_cache = {}
local current_appearance = nil

local function load_scheme(scheme_name)
	-- First, try built-in schemes
	local scheme = wezterm.get_builtin_color_schemes()[scheme_name]

	if scheme then
		return scheme
	end

	-- Not built-in, try to load from custom colors directory
	local colors_dir = wezterm.config_dir .. "/colors"
	local success, files = pcall(wezterm.read_dir, colors_dir)

	if success and files then
		for _, file_path in ipairs(files) do
			if file_path:match("%.toml$") then
				local load_success, result = pcall(function()
					local s, metadata = wezterm.color.load_scheme(file_path)
					return { scheme = s, metadata = metadata }
				end)

				if load_success and result and result.metadata then
					if result.metadata.name == scheme_name then
						return result.scheme
					end

					if result.metadata.aliases then
						for _, alias in ipairs(result.metadata.aliases) do
							if alias == scheme_name then
								return result.scheme
							end
						end
					end
				end
			end
		end
	end

	return nil
end

-- Internal function to refresh cache based on appearance
local function refresh_cache(appearance)
	-- Skip if appearance hasn't changed
	if appearance == current_appearance and color_cache.scheme_name then
		return
	end

	current_appearance = appearance
	local scheme_name = appearance:find("Dark") and themes.dark or themes.light

	local scheme = load_scheme(scheme_name)
	if scheme then
		color_cache = scheme
		color_cache.scheme_name = scheme_name
		wezterm.log_info("Colors refreshed for: " .. scheme_name)
	else
		wezterm.log_error("Could not find scheme: " .. scheme_name)
	end
end

-- Called from wezterm.lua at startup
function M.init()
	local success, appearance = pcall(function()
		return wezterm.gui.get_appearance()
	end)

	if success and appearance then
		refresh_cache(appearance)
	else
		-- Default to dark if we can't get appearance at startup
		refresh_cache("Dark")
	end
end

-- Called from events with window context to ensure correct appearance
function M.refresh(window)
	if window then
		local appearance = window:get_appearance()
		refresh_cache(appearance)
	end
end

function M.get(key, fallback)
	if type(key) == "string" and color_cache[key] then
		return color_cache[key]
	end

	if type(key) == "number" then
		local lua_index = key + 1
		if color_cache.ansi and color_cache.ansi[lua_index] then
			return color_cache.ansi[lua_index]
		end
		if key >= 8 and color_cache.brights then
			local bright_index = key - 7
			if color_cache.brights[bright_index] then
				return color_cache.brights[bright_index]
			end
		end
	end

	return fallback or "#ffffff"
end

function M.get_scheme_name()
	return color_cache.scheme_name or themes.dark
end

function M.get_all()
	return color_cache
end

-- Quick color accessors
function M.bg()
	return M.get("background", "#303446")
end

function M.fg()
	return M.get("foreground", "#c6d0f5")
end

function M.cursor()
	return M.get("cursor_bg", "#c6d0f5")
end

function M.red()
	return M.get(1, "#D14D41")
end

function M.green()
	return M.get(2, "#a6e3a1")
end

function M.yellow()
	return M.get(3, "#f5c2e7")
end

function M.blue()
	return M.get(4, "#89b4fa")
end

function M.magenta()
	return M.get(5, "#ca9ee6")
end

function M.cyan()
	return M.get(6, "#94e2d5")
end

function M.white()
	return M.get(7, "#f4b8e4")
end

function M.bright_black()
	return M.get(8, "#a5adce")
end

return M
