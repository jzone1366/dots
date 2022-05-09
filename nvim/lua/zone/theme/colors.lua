local cur_theme = require('zone.theme.plugins').theme
local colors = {}
local mod = 'zone.theme.integrated.'
local supported_themes = require('zone.theme.plugins').supported_themes

for _, theme in pairs(supported_themes) do
  if theme == cur_theme then
    colors = require(mod .. theme)
  end
end

if vim.tbl_isempty(colors) then
  return false
end

return colors
