local M = {}

-- Mappings.
function M.init(client, bufnr)
  local buf_map = require('zone.utils').create_buf_map(bufnr, { noremap = false })
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', { desc = 'Go To Definition' })
  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Go To Declaration' })
  buf_map(
    'n',
    'gi',
    '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
    { desc = 'Go To Implementations' }
  )
  buf_map(
    'n',
    'gt',
    '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
    { desc = 'Go To Type Definition' }
  )
  buf_map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { desc = 'Go To Reference' })
  buf_map('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })

  -- diagnostics
  buf_map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Prev Diagnostic' })
  buf_map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next Diagnostic' })
  buf_map(
    'n',
    'ge',
    '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>',
    { desc = 'Show Current Line Diagnostic' }
  )
  buf_map('n', '<leader>ldb', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Show Buffer Diagnostics' })
  buf_map('n', '<leader>ldw', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace Diagnostics' })

  -- hover
  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Show Documentation' })

  -- code actions
  buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_actions()<cr>', { desc = 'Code Actions' })
  buf_map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_actions()<cr>', { desc = 'Range Code Actions' })

  -- formatting
  buf_map('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', { desc = 'Format' })
  buf_map('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', { desc = 'Range Format' })

  -- lsp workspace
  buf_map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', { desc = 'Add Workspace Folder' })
  buf_map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', { desc = 'Remove Workspace Folder' })
  buf_map(
    'n',
    '<leader>wl',
    '<cmd>lua require("zone.utils.logger"):log(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
    { desc = 'Show Workspace Folders' }
  )

  if client.name == 'tsserver' then
    -- typescript helpers
    buf_map('n', '<leader>gr', ':TSLspRenameFile<CR>', { desc = 'TS Rename File' })
    buf_map('n', '<leader>go', ':TSLspOrganize<CR>', { desc = 'TS Organize' })
    buf_map('n', '<leader>gi', ':TSLspImportAll<CR>', { desc = 'TS Import All' })
  end
end

return M
