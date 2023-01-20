return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('zone.plugins.todo-comments.config')
  end,
  event = 'VeryLazy',
}
