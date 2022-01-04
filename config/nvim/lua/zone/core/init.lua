local zone_modules = {
  'zone.core.disabled',
  'zone.plugins.init',
  'zone.core.commands',
  'zone.core.editor',
  'zone.config.editor',
  'zone.core.mappings',
  'zone.config.mappings',
}

for _, mod in ipairs(zone_modules) do
  local ok, err = pcall(require, mod)
  if not ok and not mod:find('zone.config') then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
