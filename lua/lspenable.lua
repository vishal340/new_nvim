local lsps = {

	{ "ltex_plus" },
	{ "sqlls", { filetypes = { "sql", "mysql", "postgres" } } },
	{ "gopls" },
	{ "ts_ls" },
	{ "jsonls" },
	{ "yamlls" },
	{ "rust_analyzer" },
	{ "taplo" },
	{ "vimls" },
	{ "bashls" },
	{ "html" },
	{ "htmx" },
	{ "cmake" },
	{ "dockerls" },
	{ "docker_compose_language_service" },
	{ "gradle_ls" },
	{
		"clangd",
		{
			root_markers = {
				"Makefile",
				"configure.ac",
				"configure.in",
				"config.h.in",
				"build.ninja",
				"compile_commands.json",
				"compile_flags.txt",
			},
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				"--header-insertion=iwyu",
				"--query-driver=/usr/lib/llvm-13/bin/clang++",
				"--all-scopes-completion",
				"--completion-style=detailed",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			filetypes = { "c", "cpp" },
		},
	},
	{
		"lua_ls",
		{
			single_file_support = true,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.env.VIMRUNTIME,
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
			filetype = { "lua" },
		},
	},
	{
		"jdtls",
		{
			init_options = {
				jvm_args = {},
				workspace = "/home/user/.cache/jdtls/workspace",
				bundles = {
					"$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar",
				},
			},
			filetype = { "java" },
		},
	},
	{
		"pyright",
		{
			settings = {
				python = {
					analysis = {
						diagnosticSeverityOverrides = {
							reportUnusedExpression = "none",
						},
					},
				},
			},
			filetype = { "py" },
		},
	},
}
for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	vim.lsp.enable(name)
	if config then
		vim.lsp.config(name, config)
	end
end
