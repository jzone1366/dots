local opts = {
	ensure_installed = {
    "bashls",
		"clangd",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"emmet_ls",
		"eslint",
    "gopls",
    "graphql",
    "helm_ls",
		"html",
		"jsonls",
		"lua_ls",
		"pylsp",
		"rust_analyzer",
    "sqlls",
    "tailwindcss",
    "terraformls",
		"tsserver",
		"vimls",
		"yamlls",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = "williamboman/mason.nvim",
}
