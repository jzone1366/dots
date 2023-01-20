local clrs = require('catppuccin.palettes').get_palette()

return {
  normal = clrs.lavender,
  insert = clrs.green,
  terminal = clrs.green,
  visual = clrs.flamingo,
  replace = clrs.maroon,
  select = clrs.maroon,
  command = clrs.peach,
  prompt = clrs.teal,
  more = clrs.teal,
  confirm = clrs.mauve,
  shell = clrs.green,

  text = clrs.text,
  subtext = clrs.subtext2,

  bg = clrs.base,
  dark_bg = clrs.mantle,
  darker_bg = clrs.crust,

  error = clrs.red,
  warning = clrs.yellow,
  hint = clrs.teal,
  info = clrs.pink,
  success = clrs.green,

  git = {
    add = clrs.green,
    changed = clrs.blue,
    removed = clrs.red,
  },
}
