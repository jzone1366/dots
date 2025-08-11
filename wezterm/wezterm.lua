local wezterm = require("wezterm")
local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local colors = require("utils.colors")
colors.init()

-- Apply configurations
require("core.appearance").apply(config)
require("core.launch").apply(config)
require("core.keybindings").apply(config)
require("core.events").setup()

--config.window_padding = {
--	left = 5,
--	right = 5,
--	top = 5,
--	bottom = 5,
--}
--
--config.inactive_pane_hsb = {
--	saturation = 0.8,
--	brightness = 0.7,
--}
--
--config.use_dead_keys = false
--config.default_workspace = "main"
--config.scrollback_lines = 5000
--config.adjust_window_size_when_changing_font_size = false
--config.force_reverse_video_cursor = true
--config.default_cursor_style = "SteadyBar"
----config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"   -- RESIZE
--config.window_decorations = "RESIZE"
--config.max_fps = 240
--
--appearance.apply_to_config(config)
--tab.apply_to_config(config)

return config
