local u = require('zone.utils')
local map = u.map

map('n', '<leader>ff', '', {
  callback = require('zone.plugins.telescope.utils').project_files,
  desc = 'Find File',
})
map('n', '<leader>fp', ':Telescope find_files<cr>', { desc = 'Find project file' })
map('n', '<leader>fk', ':Telescope buffers<cr>', { desc = 'Find buffer' })
map('n', '<leader>fs', ':Telescope live_grep<cr>', { desc = 'Grep String' })
map('n', '<leader>fw', ':Telescope grep_string<cr>', { desc = 'Grep current word' })

-- git navigation
map('n', '<leader>ggc', ':Telescope git_commits<cr>', { desc = 'Git commits' })
map('n', '<leader>ggs', ':Telescope git_status<cr>', { desc = 'Git status' })
