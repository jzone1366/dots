local set_highlight = require('zone.theme.utils').set_highlight

-- terminal highlights
set_highlight('FloatBorder', {
  guibg = 'None',
})

vim.cmd('hi! link FloatermBorder FloatBorder')
