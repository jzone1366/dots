vim.cmd([[
command! ZoneNvimUpdate lua require('zone.utils').update()
command! ZoneNvimReloadConfig lua require('zone.utils').reload_user_config()
command! ZoneNvimReload lua require('zone.utils').reload_zone()
]])
