return {
  'airblade/vim-rooter',
  event = 'VeryLazy',
  config = function()
    vim.g.rooter_patterns = { '.git', 'package.json', '_darcs', '.bzr', '.svn', 'Makefile' } -- Default
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_resolve_links = 1
  end,
}
