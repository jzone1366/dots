-- https://wezfurlong.org/wezterm/config/lua/window/get_appearance.html
local wezterm = require("wezterm")

function Scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Builtin Solarized Dark"
	else
		return "Builtin Solarized Light"
	end
end

wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = Scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return {}
