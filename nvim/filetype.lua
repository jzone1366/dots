local extension = {
  log = 'log',
  tmpl = 'html',
}

local filename = {
  ['.env'] = 'config',
  ['.envrc'] = 'config',
  ['.yamlfmt'] = 'yaml',
}

vim.filetype.add({
  extension = extension,
  filename = filename,
})
