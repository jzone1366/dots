local M = {}

-- Mappings.
function M.init(client, bufnr)
  local buf_map = require('zone.utils').create_buf_map(bufnr, { noremap = false })
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map('n', 'gd', function() require('telescope_builtin').lsp_definitions({ reuse_win = true }) end,
    { desc = 'Go To Definition' })
  buf_map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go To Declaration' })
  buf_map(
    'n',
    'gI',
    function() require('telescope.builtin').lsp_impmentations({ reuse_win = true }) end,
    { desc = 'Go To Implementations' }
  )
  buf_map(
    'n',
    'gy',
    function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end,
    { desc = 'Go To Type Definition' }
  )
  buf_map('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Go To Reference' })
  buf_map('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename' })
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
  buf_map('n', 'K', vim.lsp.buf.hover, { desc = 'Show Documentation' })
  buf_map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Actions' })
  buf_map('n', '<leader>cA',
    function() vim.lsp.buf.code_action({ context = { only = { 'source', }, diagnostics = {}, } }) end,
    { desc = 'Code Actions' })
  buf_map('n', '<leader>gf', vim.lsp.buf.format, { desc = 'Format' })

  -- lsp workspace
  buf_map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add Workspace Folder' })
  buf_map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove Workspace Folder' })
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
