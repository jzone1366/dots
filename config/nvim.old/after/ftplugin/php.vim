" Use deoplete.
call deoplete#enable()

" Use smartcase.
call deoplete#custom#option('smart_case', v:true)

" VIM LSP {{{
nnoremap <silent> <Leader>de    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> gi            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs            <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <Leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
" }}}

