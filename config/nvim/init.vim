" ______                  _       _ _         _           
"|___  /                 (_)     (_) |       (_)          
"   / / ___  _ __   ___   _ _ __  _| |___   ___ _ __ ___  
"  / / / _ \| '_ \ / _ \ | | '_ \| | __\ \ / / | '_ ` _ \ 
" / /_| (_) | | | |  __/ | | | | | | |_ \ V /| | | | | | |
"/_____\___/|_| |_|\___| |_|_| |_|_|\__(_)_/ |_|_| |_| |_|

" vim-plug {{{
" Install vim-plug if not installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Completion {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" }}}

" LSP {{{
Plug 'Shougo/deoplete-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'deoplete-plugins/deoplete-jedi'
" }}}

" UI {{{
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'tjdevries/colorbuddy.nvim'
"Plug 'npxbr/gruvbox.nvim'
" }}}

" GENERAL {{{
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" }}}

" C# {{{
Plug 'OmniSharp/omnisharp-vim'

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'

" Timeout in seconds to wait for the server to respond.
let g:OmniSharp_timeout = 5
" }}}

" Go {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" vim-go syntax settings
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
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
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
" }}}

" Typescript/Javascript {{{
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'neoclide/vim-jsx-improve'
Plug 'burner/vim-svelte'
" }}}

" JSON {{{
Plug 'elzr/vim-json'
Plug 'GutenYe/json5.vim'
" }}}

" HTML || TEMPLATES {{{
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug'
" }}}

" GRPC/PROTOBUF {{{
Plug 'uarun/vim-protobuf'
" }}}
call plug#end()

let g:vim_home = get(g:, 'vim_home', expand('~/.config/nvim/'))
let config_list = [
            \ 'autocmd.vim',
            \ 'config.vim',
            \ 'keymappings.vim',
            \ 'plugin_settings.vim'
            \]

for files in config_list
    for f in glob(g:vim_home.files, 1, 1)
        exec 'source' f
    endfor
endfor
