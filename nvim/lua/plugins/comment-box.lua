return {
  'LudoPinelli/comment-box.nvim',
  lazy = false,
  keys = {
    { '<leader>ac', "<cmd>lua require('comment-box').llbox()<CR>", desc = 'comment box' },
    { '<leader>ac', "<cmd>lua require('comment-box').llbox()<CR>", mode = 'v', desc = 'comment box' },
  },
}
