return {
  'numToStr/Comment.nvim',
  config = function()
    require('zone.plugins.comments')
  end,
  event = 'VeryLazy',
}
