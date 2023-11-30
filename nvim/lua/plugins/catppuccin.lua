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
      -- Define Diagonostic Signs
      vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = "󰌵", texthl = "DiagnosticSignHint" })

      local config = {
        integrations = {
          alpha = true,
          mini = true,
          neotree = true,
          nvimtree = false,
          lsp_trouble = true,
          which_key = true,
        },
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
