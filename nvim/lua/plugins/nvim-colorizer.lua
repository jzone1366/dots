return {
  'NvChad/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('colorizer').setup({
      filetypes = {
        "*",
        css = { css = true, tailwind = false },
        scss = { css = true, tailwind = false },
      },
      user_default_options = {
        names = false,
        mode = 'virtualtext',
        tailwind = false, -- Enable tailwind colors
      },
    })
  end,
}
