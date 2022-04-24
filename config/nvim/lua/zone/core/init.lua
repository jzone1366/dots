local zone_modules = {
  'zone.core.disabled',
  'zone.plugins.init',
  'zone.core.commands',
  'zone.core.editor',
  'zone.core.mappings',
}

for _, mod in ipairs(zone_modules) do
  local ok, err = pcall(require, mod)
  if not ok then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
