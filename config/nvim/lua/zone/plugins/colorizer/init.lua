local filetypes = {
  '*',
}

--stylua: ignore
local opts = {
  RGB      = true;         -- #RGB hex codes
  RRGGBB   = true;         -- #RRGGBB hex codes
  names    = true;         -- "Name" codes like Blue
  RRGGBBAA = true;         -- #RRGGBBAA hex codes
  rgb_fn   = true;         -- CSS rgb() and rgba() functions
  hsl_fn   = true;         -- CSS hsl() and hsla() functions
  css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
  mode     = 'background';
}

require('colorizer').setup(filetypes, opts)
