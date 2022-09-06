local modules = {
  'zone.core',
  'zone.compiled',
  'zone.theme',
}

for _, mod in ipairs(modules) do
  local ok, err = pcall(require, mod)
  if mod == 'zone.compiled' and not ok then
    vim.notify('Run :PackerCompile!', vim.log.levels.WARN, {
      title = 'ZoneNvim',
    })
  elseif not ok then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
