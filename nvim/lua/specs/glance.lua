return -- Pretty window for navigating LSP locations
{
  'dnlhc/glance.nvim',
  enabled = false,
  cmd = 'Glance',
		-- stylua: ignore
		keys = {
			{ '<leader>cg', '', desc = '+glance' },
			{ '<leader>cgd', '<cmd>Glance definitions<CR>', desc = 'Glance Definitions' },
			{ '<leader>cgr', '<cmd>Glance references<CR>', desc = 'Glance References' },
			{ '<leader>cgy', '<cmd>Glance type_definitions<CR>', desc = 'Glance Type Definitions' },
			{ '<leader>cgi', '<cmd>Glance implementations<CR>', desc = 'Glance implementations' },
			{ '<leader>cgu', '<cmd>Glance resume<CR>', desc = 'Glance Resume' },
		},
  opts = function()
    local actions = require('glance').actions
    return {
      folds = {
        fold_closed = '󰅂', -- 󰅂 
        fold_open = '󰅀', -- 󰅀 
        folded = true,
      },
      mappings = {
        list = {
          ['<C-u>'] = actions.preview_scroll_win(5),
          ['<C-d>'] = actions.preview_scroll_win(-5),
          ['sg'] = actions.jump_vsplit,
          ['sv'] = actions.jump_split,
          ['st'] = actions.jump_tab,
          ['p'] = actions.enter_win('preview'),
        },
        preview = {
          ['q'] = actions.close,
          ['p'] = actions.enter_win('list'),
        },
      },
    }
  end,
}
