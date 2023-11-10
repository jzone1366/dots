-- Keymaps that are sent to plugins during configuration
-- Return a module here so we can keep all keymap definitions
-- in the same place.
-- This is only for global keys, other contexts
-- (such as in the cmp selection menu) may be defined
-- in their respective files.
local M = {}

-- Wrap it in a function to prevent requiring this file evaluates
-- global keymaps multiple times.
M.init = function()
  local map = vim.keymap.set
  -- Quickfix mappings
  map('n', '<leader>ck', ':cexpr []<cr>', { desc = 'Clear list' })
  map('n', '<leader>cc', ':cclose <cr>', { desc = 'Close list' })
  map('n', '<leader>co', ':copen <cr>', { desc = 'Open list' })
  map('n', '<leader>cf', ':cfdo %s/', { desc = 'Search & Replace' })
  map('n', '<leader>cp', ':cprev<cr>zz', { desc = 'Prev Item' })
  map('n', '<leader>cn', ':cnext<cr>zz', { desc = 'Next Item' })

  -- buffer navigation
  map('n', '<leader>bp', ':bprev<cr>', { desc = 'Prev buffer' })
  map('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
  map('n', '<leader>bd', ':bdelete<cr>', { desc = 'Delete buffer' })

  -- tab navigation
  map('n', '<leader>tp', ':tabprevious<cr>', { desc = 'Prev tab' })
  map('n', '<leader>tn', ':tabnext<cr>', { desc = 'Next tab' })
  map('n', '<leader>td', ':tabclose<cr>', { desc = 'Close tab' })

  -- windows
  map('n', '<leader>ww', '<C-W>p', { desc = 'Other window', remap = true })
  map('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })
  map('n', '<leader>w-', '<C-W>s', { desc = 'Split window below', remap = true })
  map('n', '<leader>w|', '<C-W>v', { desc = 'Split window right', remap = true })
  map('n', '<leader>-', '<C-W>s', { desc = 'Split window below', remap = true })

  map('n', '<C-left>', '<c-w>h')
  map('n', '<C-down>', '<c-w>j')
  map('n', '<C-up>', '<c-w>k')
  map('n', '<C-right>', '<c-w>l')
  map('n', '<leader>|', '<C-W>v', { desc = 'Split window right', remap = true })

  -- tabs
  map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
  map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
  map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
  map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
  map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
  map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
end

M.telescope = {
  {
    'z=',
    function()
      require('telescope.builtin').spell_suggest()
    end,
    silent = true,
    desc = 'Spell suggest',
  },
  {
    '<leader>ff',
    function()
      require('plugins.telescope.utils').project_files()
    end,
    silent = true,
    desc = 'Find File',
  },
  {
    '<leader>fp',
    function()
      require('telescope.builtin').find_files()
    end,
    silent = true,
    desc = 'Find Project Find',
  },
  {
    '<leader>fk',
    function()
      require('telescope.builtin').buffers()
    end,
    silent = true,
    desc = 'Find Buffer',
  },
  {
    '<leader>fs',
    function()
      require('telescope.builtin').live_grep()
    end,
    silent = true,
    desc = 'Live Grep',
  },
  {
    '<leader>fw',
    function()
      require('telescope.builtin').grep_string()
    end,
    silent = true,
    desc = 'Grep Current Word',
  },
  {
    '<leader>ggc',
    function()
      require('telescope.builtin').git_commits()
    end,
    silent = true,
    desc = 'Git Commits',
  },
  {
    '<leader>ggs',
    function()
      require('telescope.builtin').git_status()
    end,
    silent = true,
    desc = 'Git Status',
  },
}

M.terminal = {
  {
    '<C-t>',
  },
}

M.gitsigns = function(buffer)
  local gitsigns = package.loaded.gitsigns
  local map = vim.keymap.set
  map('n', ']h', gitsigns.next_hunk, { silent = true, buffer = buffer, desc = 'Next hunk' })
  map('n', '[h', gitsigns.prev_hunk, { silent = true, buffer = buffer, desc = 'Prev hunk' })
  map('n', '<leader>hs', gitsigns.stage_hunk, { silent = true, buffer = buffer, desc = 'Stage hunk' })
  map('n', '<leader>hr', gitsigns.reset_hunk, { silent = true, buffer = buffer, desc = 'Reset hunk' })
  map('v', '<leader>hs', function()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end, { silent = true, buffer = buffer, desc = 'Stage hunk' })
  map('v', '<leader>hr', function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end, { silent = true, buffer = buffer, desc = 'Reset hunk' })
  map('n', '<leader>hb', function()
    gitsigns.blame_line({ full = true })
  end, { silent = true, buffer = buffer, desc = 'Blame hunk' })
end

M.global_lsp = function()
  local map = vim.keymap.set
  map('n', ']d', vim.diagnostic.goto_next, { silent = true, desc = 'Next diagnostic' })
  map('n', '[d', vim.diagnostic.goto_prev, { silent = true, desc = 'Prev diagnostic' })
end

M.buf_lsp = function(_, bufnr)
  local buf_map = require('utils').create_buf_map(bufnr, { noremap = false })
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map('n', 'gd', function()
    require('telescope_builtin').lsp_definitions({ reuse_win = true })
  end, { desc = 'Go To Definition' })
  buf_map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go To Declaration' })
  buf_map('n', 'gI', function()
    require('telescope.builtin').lsp_impmentations({ reuse_win = true })
  end, { desc = 'Go To Implementations' })
  buf_map('n', 'gy', function()
    require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
  end, { desc = 'Go To Type Definition' })
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
  buf_map('n', '<leader>cA', function()
    vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } })
  end, { desc = 'Code Actions' })
  buf_map('n', '<leader>gf', vim.lsp.buf.format, { desc = 'Format' })

  -- lsp workspace
  buf_map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add Workspace Folder' })
  buf_map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove Workspace Folder' })
  buf_map(
    'n',
    '<leader>wl',
    '<cmd>lua require("utils.logger"):log(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
    { desc = 'Show Workspace Folders' }
  )
end

M.neotree = function()
  local map = require('utils').map

  map('n', '<C-n>', ':Neotree toggle<CR>')
end

M.dial = {
  {
    '<C-a>',
    function()
      require('dial.map').manipulate('increment', 'normal')
    end,
    desc = 'Increment number',
  },
  {
    '<C-x>',
    function()
      require('dial.map').manipulate('decrement', 'normal')
    end,
    desc = 'Decrement number',
  },
  {
    '<C-a>',
    mode = { 'v' },
    function()
      require('dial.map').manipulate('increment', 'visual')
    end,
    desc = 'Increment number',
  },
  {
    '<C-x>',
    mode = { 'v' },
    function()
      require('dial.map').manipulate('decrement', 'visual')
    end,
    desc = 'Decrement number',
  },
}

M.trouble = {
  {
    ']t',
    function()
      require('trouble').next({ skip_groups = true, jump = true })
    end,
    desc = 'Next trouble',
    silent = true,
  },
  {
    '[t',
    function()
      require('trouble').previous({ skip_groups = true, jump = true })
    end,
    desc = 'Prev trouble',
    silent = true,
  },
  {
    ']T',
    function()
      require('trouble').last({ skip_groups = true, jump = true })
    end,
    desc = 'Last trouble',
    silent = true,
  },
  {
    '[T',
    function()
      require('trouble').first({ skip_groups = true, jump = true })
    end,
    desc = 'First trouble',
    silent = true,
  },
}

return M
