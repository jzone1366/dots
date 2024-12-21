return {
  'folke/trouble.nvim',
  opts = {
    auto_jump = true, -- auto jump to the item when there's only one
    focus = true, -- Focus the window when opened
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    preview = {
      type = 'main',
      -- Set to false, if you want the preview to always be a real loaded buffer.
      scratch = true,
    },
    win = {
      border = vim.g.border_style,
      size = 0.38, -- This weird size makes sense with the resize autocmd
    },
    modes = {
      symbols = {
        win = { position = 'right' },
        focus = true,
      },
      diagnostics = {
        win = { position = 'right' },
        focus = true,
      },
    },
  },
  cmd = { 'TroubleToggle', 'Trouble' },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
}
