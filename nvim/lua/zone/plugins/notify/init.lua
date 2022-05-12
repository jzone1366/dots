local icons = require("zone.theme.icons")
local utils = require("zone.utils")

local notify = require("notify")

notify.setup({
	icons = {
		ERROR = icons.error,
		WARN = icons.warn,
		INFO = icons.info,
		DEBUG = icons.debug,
		TRACE = icons.trace,
	},
	background_colour = require("zone.theme.colors").bg,
})

vim.notify = notify

require("zone.plugins.notify.highlights")
