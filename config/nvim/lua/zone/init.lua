local mods = {
  'zone.compiled',
  'zone.core',
  'zone.theme',
}

for _, mod in ipairs(mods) do
  local ok, err = pcall(require, mod)
  if mod == 'zone.compiled' and not ok then
    vim.notify('Run :PackerCompile!', vim.log.levels.WARN, {
      title = 'ZoneNvim',
    })
  elseif not ok and not mod:find('zone.config') then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
