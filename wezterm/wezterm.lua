local wezterm = require("wezterm")
local keys = require("keys")
local tab = require("tab")
local appearance = require("appearance")

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end


config.leader = keys.leader
config.keys = keys.keys


-- Now I can use an unpatched font and have a fallback for the symbols.
config.font = wezterm.font_with_fallback({
  "Monaspace Xenon",
  "Symbols Nerd Font",
})
config.font_size = 16

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7
}

config.use_dead_keys = false
config.default_workspace = "main"
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.force_reverse_video_cursor = true
config.default_cursor_style = "SteadyBar"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"   -- RESIZE


tab.setup(config)
appearance.setup(config)

return config
