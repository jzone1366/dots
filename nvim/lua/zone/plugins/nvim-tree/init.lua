local g = vim.g
local icons = require("zone.theme.icons")
local augroup_name = "ZoneNvimNvimTree"
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

-- settings
g.nvim_tree_git_hl = 1
g.nvim_tree_refresh_wait = 300

g.nvim_tree_special_files = {}

g.nvim_tree_icons = {
	default = "",
	symlink = icons.symlink,
	git = icons.git,
	folder = icons.folder,

	lsp = {
		hint = icons.hint,
		info = icons.info,
		warning = icons.warn,
		error = icons.error,
	},
}

g.nvim_tree_respect_buf_cwd = 1

-- set up args
local args = {
	diagnostics = {
		enable = true,
	},
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 50,
		number = true,
		relativenumber = true,
	},
	git = {
		ignore = true,
	},
}

vim.api.nvim_create_autocmd("BufEnter", {
	command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
	group = group,
	nested = true,
})

require("nvim-tree").setup(args)
