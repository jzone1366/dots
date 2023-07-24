local config = {
  flavour = 'latte',
  --   color_overrides = {
  --       mocha = {
  --           base = "#121212",
  --       },
  --   },
  integrations = {
    nvimtree = true,
  },
  highlight_overrides = {
    mocha = function(mocha)
      return {
        NvimTreeNormal = { bg = mocha.none },
      }
    end,
    latte = function(latte)
      return {
        NvimTreeNormal = { bg = latte.none },
      }
    end,
  },
}

return config
