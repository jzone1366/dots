local icons = require('zone.theme.icons')
local config = require('zone.config')

require('notify').setup(vim.tbl_deep_extend('force', {
  icons = {
    ERROR = icons.error,
    WARN = icons.warn,
    INFO = icons.info,
    DEBUG = icons.debug,
    TRACE = icons.trace,
  },
  background_colour = require('zone.theme.colors').notify_bg,
}, config.notify or {}))
vim.notify = require('notify')
