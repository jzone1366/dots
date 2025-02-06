local utils = require('utils')

utils.augroup('Utilities', {
  {
    event = { 'VimResized' },
    --     desc = "Automatically resize windows in all tabpages when resizing Vim",
    command = function(args)
      vim.schedule(function()
        vim.cmd('tabdo wincmd =')
        swift.resize_windows(args.buf)
      end)
    end,
  },
})
