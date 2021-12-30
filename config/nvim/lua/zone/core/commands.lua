vim.cmd([[
  command! ZoneUpdate lua require('zone.utils').update()
  command! ZoneReload lua require('zone.utils').reload_user_config(true)
  command! ZoneReloadSync lua require('zone.utils').reload_user_config_sync()
  command! LspFormat lua vim.lsp.buf.formatting()

  augroup Zone_Auto_Resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
]])
