local icons = require('theme.icons')

local M = {
  indent_scope_char = '│',
  border_style = 'rounded',
  icons = icons,
}

function M.get_border(highlight)
  -- single border but heavier and with custom highlight when needed
  -- https://github.com/neovim/neovim/blob/99e0facf3a001608287ec6db69b01c77443c7b9d/src/nvim/api/win_config.c#L935C19-L935C57
  return {
    { '┏', highlight or 'FloatBorder' },
    { '━', highlight or 'FloatBorder' },
    { '┓', highlight or 'FloatBorder' },
    { '┃', highlight or 'FloatBorder' },
    { '┛', highlight or 'FloatBorder' },
    { '━', highlight or 'FloatBorder' },
    { '┗', highlight or 'FloatBorder' },
    { '┃', highlight or 'FloatBorder' },
  }
end

return M
