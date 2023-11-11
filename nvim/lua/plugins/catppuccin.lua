local os_is_dark = function()
  return (vim.call(
    'system',
    [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
  )):find('dark') ~= nil
end

return {
  { -- color scheme
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local config = {
        --   color_overrides = {
        --       mocha = {
        --           base = "#121212",
        --       },
        --   },
        integrations = {
          alpha = true,
          mini = true,
          neotree = true,
          nvimtree = false,
          lsp_trouble = true,
          which_key = true,
        },
        --highlight_overrides = {
        --  mocha = function(mocha)
        --    return {
        --      NeoTreeNormal = { bg = mocha.none },
        --    }
        --  end,
        --  latte = function(latte)
        --    return {
        --      NeoTreeNormal = { bg = latte.none },
        --    }
        --  end,
        --},
      }

      require('catppuccin').setup(config)
      if os_is_dark() then
        vim.cmd('color catppuccin-mocha')
      else
        vim.cmd('color catppuccin-latte')
      end
    end,
  },
}
