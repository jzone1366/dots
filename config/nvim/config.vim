" LEADERS {{{
let mapleader="\<SPACE>"
let maplocalleader=","
" }}}

" UI Layout {{{
set number					" Show line numbers
set showcmd					" Show command in bottom bar
set cursorline	            			" Highlight current line
set showmatch		        		" Highlight matching parenthesis
filetype plugin indent on   			" Set filetype indentation detection
set wildmenu		        		" visual autocomplete for command menu
set lazyredraw					" redraw only when we need to
set laststatus=2
set autoindent					" Turn on auto indentation
set backspace=indent,eol,start			" Proper backspace behavior.
set noswapfile					" Don't use swapfile
set nobackup					" No Backups
set noshowmode					" Turn off mode since it shows in lightline
set cmdheight=2
set scrolloff=8					" Start scolling 4 lines from the bottom
set encoding=utf-8
"set updatetime=100                              " Let plugins show effects after 100ms
set linespace=0                                 " Set line-spacing to minimum

syntax enable					" enable syntax processing

if has('nvim') || has('termguicolors')
  set termguicolors
endif

if has('nvim') || has('patch-8.1.0360')
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" Tabs {{{
set tabstop=4       				" The width of a TAB is set to 4.
set shiftwidth=4    				" Indents will have a width of 4
set expandtab       				" Expand TABs to spaces
" }}}

" Searching {{{
set ignorecase		          		" ignore case when searching
set incsearch		          		" search as characters are entered
set hlsearch		          		" highligh all matches
" }}}

" Finding Files {{{
set path+=**                      		" Search down into sub folders
set wildignore+=*/node_modules/*  		" Ignore node_modules
" }}}


" COLOR SCHEME CONFIG
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
" }}}

" StatusLine {{{
hi StatusLine cterm=none term=none ctermfg=13 ctermbg=none
hi StatusLineNC term=none cterm=none ctermfg=0 ctermbg=none
" }}}
