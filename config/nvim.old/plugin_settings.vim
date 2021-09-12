" Globals {{{
let g:typescript_indent_disable = 1
let g:netrw_altv = 1
" }}}

" Neovim LSP Diagnosics {{{
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1
" }}}

" LIGHTLINE {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \ 'cocstatus': 'coc#status'
      \ },
\ }
" }}}

lua require 'lsp'
