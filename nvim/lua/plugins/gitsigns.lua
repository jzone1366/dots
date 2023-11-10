local opts = {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '-' },
    changedelete = { text = '~' },
  },
  on_attach = require('core.keymaps').gitsigns,
}

return {
  'lewis6991/gitsigns.nvim',
  opts = opts,
  event = { 'BufReadPre', 'BufNewFile' },
}
