local group = function(name)
  return vim.api.nvim_create_augroup('zonenvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('VimResized', {
  command = 'tabdo wincmd =',
  group = group('resize_splits'),
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = 'Briefly highlight yanked text',
  group = group('highlight_yank'),
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = group('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = group('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
