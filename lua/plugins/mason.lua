return {
	"mason-org/mason.nvim",
	opts = {},
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function(_, opts)
		require("mason").setup(opts)
		require("mason-tool-installer").setup({
			ensure_installed = {
				"clangd",
				"clang-format",
				"lua-language-server",
				"stylua",
				"pyright",
				"debugpy",
				"codelldb",
				"bash-debug-adapter",
				"js-debug-adapter",
				"rust-analyzer",
				"gopls",
				"typescript-language-server",
				"json-lsp",
				"yaml-language-server",
				"taplo",
				"dockerfile-language-server",
				"docker-compose-language-service",
				"html-lsp",
				"bash-language-server",
				"sqlls",
				"sqlfmt",
				"prettier",
				"black",
				"shfmt",
				"jdtls",
				"java-debug-adapter",
				"java-test",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}
