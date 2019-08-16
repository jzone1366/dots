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

" UI {{{
Plug 'itchyny/lightline.vim'
"Plug 'jacoborus/tender.vim'
"Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
"Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
"Plug 'tomasr/molokai'
"Plug 'taigacute/gruvbox9'
Plug 'joshdick/onedark.vim'
Plug 'srcery-colors/srcery-vim'
" }}}

" GENERAL {{{
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" }}}


" Go {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" vim-go syntax settings
let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1

let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
" }}}

" CSS {{{
Plug 'ap/vim-css-color'
"Plug 'shmargum/vim-sass-colors'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
" }}}

" Typescript/Javascript {{{
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/vim-jsx-improve'
" }}}

" JSON {{{
Plug 'elzr/vim-json'
Plug 'GutenYe/json5.vim'
" }}}

" HTML || TEMPLATES {{{
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug'
" }}}

call plug#end()
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
set scrolloff=4					" Start scolling 4 lines from the bottom

syntax enable					" enable syntax processing

if has('nvim') || has('termguicolors')
  set termguicolors
endif

if has('nvim') || has('patch-8.1.0360')
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" COLOR SCHEME CONFIG
set background=dark
"let g:gruvbox_italic = 1
"let g:gruvbox_underline = 1
"colorscheme gruvbox9_hard
let g:srcery_italic = 1
colorscheme srcery

" }}}

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

" LIGHTLINE {{{
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \ 'cocstatus': 'coc#status'
      \ },
\ }
" }}}

" Globals {{{
let g:typescript_indent_disable = 1
let g:netrw_altv = 1
" }}}

" StatusLine {{
hi StatusLine cterm=none term=none ctermfg=13 ctermbg=none
hi StatusLineNC term=none cterm=none ctermfg=0 ctermbg=none
" }}
"
