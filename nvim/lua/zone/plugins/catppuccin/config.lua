local config = {
    flavour = "mocha",
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
    },
}

return config
