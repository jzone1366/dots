local g = {}

g.dragon = {
  foreground = "#c5c9c5",
  background = "#181616",

  cursor_bg = "#b6927b",
  cursor_border = "#b6927b",
  cursor_fg = "#0d0c0c",

  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",

  scrollbar_thumb = "#a6a69c",
  split = "#a6a69c",

  ansi = { "#0d0c0c", "#c4746e", "#87a987", "#c4b28a", "#8ba4b0", "#a292a3", "#8ea4a2", "#c8c093" },
  brights = { "#a6a69c", "#e46876", "#8a9a7b", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#c5c9c5" },
  indexed = { [16] = "#b6927b", [17] = "#b98d7b" }, -- surimiOrange peachred
}

g.lotus = {
  foreground = "#545464",
  background = "#f2ecbc",

  cursor_bg = "#e98a00",
  cursor_border = "#e98a00",
  cursor_fg = "#1f1f28",

  selection_fg = "#43436c",
  selection_bg = "#b5cbd2",

  scrollbar_thumb = "#a6a69c",
  split = "#a6a69c",

  ansi = { "#1f1f28", "#c84053", "#6f894e", "#77713f", "#4d699b", "#b35b79", "#597b75", "#545464" },
  brights = { "#818980", "#d7474b", "#6e915f", "#836f4a", "#6693bf", "#624c83", "#5e857a", "#43436c" },
  indexed = { [16] = "#e98a00", [17] = "#e82424" }, -- surimiOrange peachred
}

return g;
