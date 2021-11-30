local zone_modules = {
  'zone.disabled',
  'zone.pluginsInit',
  'zone.compiled',
  'zone.commands',
  'zone.editor',
  'zone.mappings',
  'zone.core.theme.highlights',
}

for _, mod in ipairs(zone_modules) do
  local ok, err = pcall(require, mod)
  if not ok then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end

local user_config_modules = {
  'zone.config.editor',
  'zone.config.mappings',
}

for _, mod in ipairs(user_config_modules) do
  pcall(require, mod)
end
