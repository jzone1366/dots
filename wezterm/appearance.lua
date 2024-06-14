local wezterm = require("wezterm")
local catppuccin = require("palettes.catppuccin")

local M = {}

local palette_mocha = {
  ansi = {
    catppuccin.mocha.black,
    catppuccin.mocha.red,
    catppuccin.mocha.green,
    catppuccin.mocha.yellow,
    catppuccin.mocha.blue,
    catppuccin.mocha.magenta,
    catppuccin.mocha.cyan,
    catppuccin.mocha.white,
  },
  brights = {
    catppuccin.mocha.bright_black,
    catppuccin.mocha.bright_red,
    catppuccin.mocha.bright_green,
    catppuccin.mocha.bright_yellow,
    catppuccin.mocha.bright_blue,
    catppuccin.mocha.bright_magenta,
    catppuccin.mocha.bright_cyan,
    catppuccin.mocha.bright_white,
  },
  indexed = {},
  background = catppuccin.mocha.background,
  foreground = catppuccin.mocha.foreground,
  cursor_bg = catppuccin.mocha.foreground,
  cursor_border = catppuccin.mocha.foreground,
  cursor_fg = catppuccin.mocha.background,
  tab_bar = {
    inactive_tab_edge = catppuccin.mocha.foreground,
    background = catppuccin.mocha.background,
    active_tab = {
      bg_color = catppuccin.mocha.black,
      fg_color = catppuccin.mocha.foreground,
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = catppuccin.mocha.background,
      fg_color = catppuccin.mocha.foreground,
      intensity = "Half",
    },
    new_tab = {
      bg_color = catppuccin.mocha.foreground,
      fg_color = catppuccin.mocha.background,
    }
  }
}

local palette_latte = {
  ansi = {
    catppuccin.latte.black,
    catppuccin.latte.red,
    catppuccin.latte.green,
    catppuccin.latte.yellow,
    catppuccin.latte.blue,
    catppuccin.latte.magenta,
    catppuccin.latte.cyan,
    catppuccin.latte.white,
  },
  brights = {
    catppuccin.latte.bright_black,
    catppuccin.latte.bright_red,
    catppuccin.latte.bright_green,
    catppuccin.latte.bright_yellow,
    catppuccin.latte.bright_blue,
    catppuccin.latte.bright_magenta,
    catppuccin.latte.bright_cyan,
    catppuccin.latte.bright_white,
  },
  indexed = {},
  background = catppuccin.latte.background,
  foreground = catppuccin.latte.foreground,
  cursor_bg = catppuccin.latte.foreground,
  cursor_border = catppuccin.latte.foreground,
  cursor_fg = catppuccin.latte.background,
  tab_bar = {
    inactive_tab_edge = catppuccin.latte.foreground,
    background = catppuccin.latte.background,
    active_tab = {
      bg_color = catppuccin.latte.black,
      fg_color = catppuccin.latte.foreground,
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = catppuccin.latte.background,
      fg_color = catppuccin.latte.foreground,
      intensity = "Half",
    },
    new_tab = {
      bg_color = catppuccin.latte.foreground,
      fg_color = catppuccin.latte.background,
    }
  }
}

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Mocha" -- dark
  else
    return "Catppuccin Latte" -- light
  end
end

local function window_frame_for_appearance(appearance)
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

local function colors_for_appearance(appearance)
  if appearance:find("Dark") then
    return palette_mocha
  else
    return palette_latte
  end
end

function M.setup(config)
  local appearance = wezterm.gui.get_appearance()
  config.color_scheme = scheme_for_appearance(appearance)
  config.window_frame = window_frame_for_appearance(appearance)
  config.colors = colors_for_appearance(appearance)
end

return M
