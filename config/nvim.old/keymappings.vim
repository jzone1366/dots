" FZF Fuzzy {{{
nnoremap <Leader>b   :Buffers<CR>
nnoremap <Leader>/   :GFiles?<CR>
nnoremap <Leader>ff  :GFiles<CR>
nnoremap <Leader>fF  :Files<CR>
nnoremap <Leader>fL  :Lines<CR>
nnoremap <Leader>fl  :BLines<CR>
nnoremap <Leader>ft  :BTags<CR>
nnoremap <Leader>fT  :Tags<CR>
nnoremap <Leader>fc  :BCommits<CR>
nnoremap <Leader>fC  :Commits<CR>
nnoremap <Leader>fh  :History:<CR>
nnoremap <Leader>fH  :History/<CR>
nnoremap <Leader>fm  :Commands<CR>
nnoremap <Leader>fo  :Locate<SPACE>
nnoremap <Leader>fk  :Maps<CR>
nnoremap <Leader>f/  :Rg<CR>
nnoremap <Leader>fs  :exe ':Rg ' . expand('<cword>')<CR>
imap <C-x><C-w> <Plug>(fzf-complete-word)
imap <C-x><C-p> <Plug>(fzf-complete-path)
imap <C-x><C-f> <Plug>(fzf-complete-file)
imap <C-x><C-l> <Plug>(fzf-complete-line)
" }}}

" Buffer Navigation {{
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>
" }}}
