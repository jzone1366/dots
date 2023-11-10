return {
  { -- color scheme
    'catppuccin/nvim',
    lazy = false,
    config = function()
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

      require('catppuccin').setup(config)
      vim.cmd('color catppuccin')
    end,
  },
}

