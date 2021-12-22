local config = require('zone.config')
local icons = require('zone.theme.icons')
local utils = require('zone.utils')

local notify = require('notify')
notify.setup(utils.merge({
  icons = {
    ERROR = icons.error,
    WARN = icons.warn,
    INFO = icons.info,
    DEBUG = icons.debug,
    TRACE = icons.trace,
  },
  background_colour = require('zone.theme.colors').notify_bg,
}, config.notify or {}))
vim.notify = notify
