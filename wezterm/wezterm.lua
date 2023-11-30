local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Mocha" -- dark
  else
    return "Catppuccin Latte" -- light
  end
end

local default_opts = {
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

  font = wezterm.font_with_fallback({
    "Monaspace Xenon",
    "Symbols Nerd Font",
  }),

  --font = wezterm.font("JetBrainsMono Nerd Font"),
  --font = wezterm.font("Iosevka Nerd Font Mono"),
  --font = wezterm.font("Monaspace Xenon"), -- Neon, Argon, Xenon, Radon, Krypton
  --font = wezterm.font("CaskaydiaCove Nerd Font"),
  --font = wezterm.font("GoMono Nerd Font"),
  --font = wezterm.font("FiraCode Nerd Font"),
  --font = wezterm.font("Hack Nerd Font"),
  font_size = 13,
  hide_tab_bar_if_only_one_tab = true,
  default_cursor_style = "SteadyBar",
  window_decorations = "RESIZE|TITLE",

  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
}

local opts = default_opts

return opts
