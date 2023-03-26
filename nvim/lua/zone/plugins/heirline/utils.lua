local colors = require('zone.plugins.heirline.components.colors')

local M = {}

function M.vi_mode_hl(hl)
  return function()
    local _hl = hl
    if _hl then
      _hl = vim.deepcopy(_hl)
    else
      _hl = { fg = true }
    end

    local color = M.mode_colors_map[vim.fn.mode()] or colors.text

    if _hl.fg == true then
      _hl.fg = color
      _hl.bg = colors.bg
    end
    if _hl.bg == true then
      _hl.bg = color
      _hl.fg = colors.bg
    end
    return _hl
  end
end

M.mode_names = {
  n = 'N',
  no = 'N?',
  nov = 'N?',
  noV = 'N?',
  ['no\22'] = 'N?',
  niI = 'Ni',
  niR = 'Nr',
  niV = 'Nv',
  nt = 'Nt',
  v = 'V',
  vs = 'Vs',
  V = 'V_',
  Vs = 'Vs',
  ['\22'] = '^V',
  ['\22s'] = '^V',
  s = 'S',
  S = 'S_',
  ['\19'] = '^S',
  i = 'I',
  ic = 'Ic',
  ix = 'Ix',
  R = 'R',
  Rc = 'Rc',
  Rx = 'Rx',
  Rv = 'Rv',
  Rvc = 'Rv',
  Rvx = 'Rv',
  c = 'C',
  cv = 'Ex',
  r = '...',
  rm = 'M',
  ['r?'] = '?',
  ['!'] = '!',
  t = 'T',
}

M.mode_colors_map = {
  n = 'red',
  i = 'green',
  v = 'cyan',
  V = 'cyan',
  ['\22'] = 'cyan',
  c = 'orange',
  s = 'purple',
  S = 'purple',
  ['\19'] = 'purple',
  R = 'orange',
  r = 'orange',
  ['!'] = 'red',
  t = 'red',
}

return M
