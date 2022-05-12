local augroup_name = "ZoneNvim"
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
	group = group,
})

vim.cmd([[
  command! ZoneUpdate lua require('zone.utils').update()
  command! ZoneReload lua require('zone.utils').reload_user_config(true)
  command! ZoneReloadSync lua require('zone.utils').reload_user_config_sync()
  command! LspFormat lua vim.lsp.buf.formatting()
]])
