-- ┌─────────────┐
-- │ Colorscheme │
-- └─────────────┘

local add, now = vim.pack.add, Config.now

now(function()
  add({ 'https://github.com/rebelot/kanagawa.nvim' })

  vim.cmd('colorscheme kanagawa-dragon')
  vim.cmd('set background=dark')
end)
