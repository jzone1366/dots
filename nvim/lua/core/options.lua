local opt = vim.opt
local g = vim.g

opt.hidden = true -- don't autosave buffers
opt.cmdheight = 1
opt.updatetime = 100 -- highlight sameids faster
opt.showmatch = true -- show matching brackets
opt.number = true
--opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes:2' -- auto show the gutter with max size
opt.wrap = false
opt.clipboard = 'unnamedplus' -- y yy d works with system clipboard
opt.hlsearch = false
opt.laststatus = 3
opt.wildignore:append({
  '*.bak',
  '*.pyc',
  '*.py~',
  '*.pdf',
  '*.so',
  '*.gif',
  '*.jpg',
  '*.flv',
  '*.class',
  '*.jar',
  '*.png',
  '*/tools/*',
  '*/docs/*',
  '*.swp',
  '*/.svn/*',
  '*/.git/*',
})
opt.wildmode = 'list:longest'
opt.wildmenu = true
opt.textwidth = 0
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.expandtab = true
opt.scrolloff = 15
opt.smarttab = true
opt.smartindent = true
opt.showmode = false
opt.fileformats = 'unix,dos'
opt.autowrite = true -- automatically save before commands like :next and :make
opt.ignorecase = true -- do case insensitive matching
opt.incsearch = true -- Incremental search
opt.ruler = true
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.smartcase = true -- do smart case matching
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 999
opt.autoread = true
opt.list = true
opt.mouse = 'a'
opt.listchars:append({ trail = '·', eol = '↩', tab = '› ' })
opt.undofile = true
opt.undodir = '/tmp/nvim/undo'

-- Globals
g.mapleader = ' '
g.maplocalleader = ';'
