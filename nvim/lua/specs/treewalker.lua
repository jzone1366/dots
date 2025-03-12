return {
  'aaronik/treewalker.nvim',

  -- The following options are the defaults.
  -- Treewalker aims for sane defaults, so these are each individually optional,
  -- and setup() does not need to be called, so the whole opts block is optional as well.
  opts = {
    -- Whether to briefly highlight the node after jumping to it
    highlight = true,

    -- How long should above highlight last (in ms)
    highlight_duration = 250,

    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = 'CursorLine',
  },
  keys = {
    { mode = { 'n' }, '<A-k>', '<cmd>Treewalker Up<CR>' },
    { mode = { 'n' }, '<A-j>', '<cmd>Treewalker Down<CR>' },
    { mode = { 'n' }, '<A-h>', '<cmd>Treewalker Left<CR>' },
    { mode = { 'n' }, '<A-l>', '<cmd>Treewalker Right<CR>' },
  },
}
