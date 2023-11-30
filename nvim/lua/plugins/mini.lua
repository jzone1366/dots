local loadEvents = { 'BufReadPre', 'BufNewFile' }
return {
  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'gsa',            -- Add surrounding in Normal and Visual modes
        delete = 'gsd',         -- Delete surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        replace = 'gsr',        -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
      version = false,
    },
    event = loadEvents
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    event = loadEvents,
    config = function()
      require('mini.pairs').setup() -- TODO: Check how to load keys without this.
    end
  },
}
