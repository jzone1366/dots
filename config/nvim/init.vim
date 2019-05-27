" zonejm init.vim

" vim-plug {{{
" Install vim-plug if not installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Completion {{{
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install'}
" }}}

" GENERAL {{{
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" }}}

" Color Scheme {{{
Plug 'jacoborus/tender.vim'
" }}}

" Go {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }}}

" CSS {{{
Plug 'ap/vim-css-color'
" }}}

" Typescript {{{
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
Plug 'Quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim'
" }}}

" Markdown {{{
Plug 'JamshedVesuna/vim-markdown-preview'
" }}}
call plug#end()
" }}}

" UI Layout {{{
set number					" Show line numbers
set showcmd					" Show command in bottom bar
set cursorline	            " Highlight current line
set showmatch		        " Highlight matching parenthesis
filetype plugin indent on   " Set filetype indentation detection
set wildmenu		        " visual autocomplete for command menu
set lazyredraw					" redraw only when we need to
set laststatus=2
set autoindent						" Turn on auto indentation
set backspace=indent,eol,start		" Proper backspace behavior.
set noswapfile						" Don't use swapfile
set nobackup						" No Backups
set noshowmode						" Turn off mode since it shows in lightline
syntax enable		          " enable syntax processing
colorscheme tender                " Use Tender Colorscheme
" }}}

" Tabs {{{
set tabstop=4       " The width of a TAB is set to 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
"set expandtab       " Expand TABs to spaces
" }}}

" Searching {{{
set ignorecase		          " ignore case when searching
set incsearch		          " search as characters are entered
set hlsearch		          " highligh all matches
" }}}

" Finding Files {{{
set path+=**                      " Search down into sub folders
set wildignore+=*/node_modules/*  " Ignore node_modules
"set rtp+=~/.fzf
" }}}

" Globals {{{
let g:typescript_indent_disable = 1
let g:lightline = {}
let g:lightline.colorscheme = 'tenderplus'
let g:netrw_altv = 1
" }}}

" StatusLine {{
hi StatusLine cterm=none term=none ctermfg=13 ctermbg=none
hi StatusLineNC term=none cterm=none ctermfg=0 ctermbg=none
" }}
