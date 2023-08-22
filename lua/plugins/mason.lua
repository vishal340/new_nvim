return{
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {"asm_lsp", "bashls", "clangd", "cmake", "dockerls", "docker_compose_language_service", "eslint", "gopls", "gradle_ls", "html", "jsonls", "ltex", "lua_ls", "ruff_lsp", "vimls"}
		},
	}
}
