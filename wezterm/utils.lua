local wezterm = require("wezterm")
local catppuccin = require("palettes.catppuccin")
local M = {}

function M.window_frame_for_appearance(appearance)
  local window_frame = {
    font = wezterm.font { family = 'Monaspace Xenon', weight = 'Bold' },
  }

  if appearance:find("Dark") then
    window_frame.active_titlebar_bg   = catppuccin.mocha.background
    window_frame.inactive_titlebar_bg = catppuccin.mocha.background
  else
    window_frame.active_titlebar_bg   = catppuccin.latte.background
    window_frame.inactive_titlebar_bg = catppuccin.latte.background
  end

  return window_frame
end

function M.get_palette_colors()
  local appearance = wezterm.gui.get_appearance()
  if appearance:find("Dark") then
    return catppuccin.mocha
  else
    return catppuccin.latte
  end
end

return M
