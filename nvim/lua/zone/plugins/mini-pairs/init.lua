return {
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>up',
      function()
        local Logger = require('zone.utils.logger')
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          Logger:warn('Disabled auto pairs', { title = 'Option' })
        else
          Logger:log('Enabled auto pairs', { title = 'Option' })
        end
      end,
      desc = 'Toggle auto pairs',
    },
  },
}
