-- Use a sublist to run the first available
local opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { {"eslint_d", "prettierd", "prettier" } },
    javascriptreact = { { "eslint_d", "prettierd", "prettier" } },
		typescript = { { "eslint_d", "prettierd", "prettier" } },
		typescriptreact = { { "eslint_d", "prettierd", "prettier" } },
		css = { { "dprint", "prettierd", "prettier" } },
		scss = { { "dprint", "prettierd", "prettier" } },
		less = { { "dprint", "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		yaml = { { "prettierd", "prettier" } },
		markdown =  { { "prettierd", "prettier" } },
		rust = { "rustfmt" },
    go = { "gofmt" },
    sql = { "sql_formatter" },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
}

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = opts,
}
