local M = {}

-- Mappings.
function M.init(client, bufnr)
  local map = require('zone.utils').map
  local opts = { buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  map('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
  map('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
  map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
  map('n', 'gn', '<cmd>lua require("zone.ui").rename()<cr>', opts)

  -- diagnostics
  map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  map('n', 'ge', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>', opts)
  map('n', '<leader>ge', '<cmd>Telescope diagnostics bufnr=0<cr>', opts)

  -- hover
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

  -- code actions
  map('n', '<leader>ca', '<cmd>lua require("zone.ui").code_actions()<cr>', opts)
  map('v', '<leader>ca', '<cmd>lua require("zone.ui").range_code_actions()<cr>', opts)

  -- formatting
  map('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  map('v', '<leader>gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)

  -- signature help
  map('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>', opts)

  -- lsp workspace
  map('n', '<leader>wd', '<cmd>Telescope diagnostics<cr>', opts)
  map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  map(
    'n',
    '<leader>wl',
    '<cmd>lua require("zone.utils.logger"):log(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
    opts
  )

  if client.name == 'tsserver' then
    -- typescript helpers
    map('n', '<leader>gr', ':TSLspRenameFile<CR>', opts)
    map('n', '<leader>go', ':TSLspOrganize<CR>', opts)
    map('n', '<leader>gi', ':TSLspImportAll<CR>', opts)
  end
end

return M