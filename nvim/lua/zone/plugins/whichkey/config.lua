local ui = require('zone.theme.ui')
local wk = require('which-key')
wk.setup({
  window = {
    border = ui.rounded,
    position = 'bottom',
    margin = { 1, 0, 1, 0 },
    padding = { 3, 2, 3, 2 },
    winblend = 20,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 8,
    align = 'center',
  },
})

wk.register({
  ['<leader>'] = {
    b = {
      name = '+buffer',
    },
    c = {
      name = '+quickfix',
    },
    f = {
      name = '+find',
    },
    h = {
      name = '+gitsigns',
      t = {
        name = '+toggle',
      },
    },
    l = {
      name = '+lsp',
      d = {
        name = '+diagnostics',
      },
      t = {
        name = '+toggle',
      },
      w = {
        name = '+workspace',
      },
    },
    g = {
      name = '+goto',
    },
    n = {
      name = '+tree',
    },
    s = {
      name = '+session',
    },
    t = {
      name = '+tab',
    },
    v = {
      name = '+vcs (git)',
      t = {
        name = '+toggle',
      },
    },
  },
})
