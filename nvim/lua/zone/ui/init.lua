local utils = require("zone.utils")
local M = {}

local default_user_opts = {
	highlight = "FloatBorder",
	border_style = "rounded",
	rename = {
		border = {
			highlight = "FloatBorder",
			style = nil,
			title = "Rename",
			title_align = "left",
			title_hl = "FloatBorder",
		},
		prompt = "> ",
		prompt_hl = "Comment",
		popup_opts = {},
	},
	code_actions = {
		min_width = nil,
		border = {
			bottom_hl = "FloatBorder",
			highlight = "FloatBorder",
			style = nil,
			title = "Code Actions",
			title_align = "center",
			title_hl = "FloatBorder",
		},
		popup_opts = {},
	},
}

M.rename = function()
	return require("zone.ui.rename")(default_user_opts)
end

M.code_actions = function(opts)
	require("zone.ui.code-action").code_actions(opts or default_user_opts)
end

M.range_code_actions = function(opts)
	opts = utils.merge({
		params = vim.lsp.util.make_given_range_params(),
	}, opts or {})
	M.code_actions(opts)
end

return M
