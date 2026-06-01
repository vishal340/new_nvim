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
			filetypes = { "c", "cpp", "cc", "cxx", "c++", "h", "hpp", "hh" },
			settings = {
				clangd = {
					InlayHints = {
						Enabled = true,
						ParameterHints = true,
						TypeHints = true,
						ChainingHints = true,
					},
				},
			},
		},
	},
	{
		"lua_ls",
		{
			single_file_support = true,
			settings = {
				Lua = {
					runtime = {
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
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".git", ".luarc.json" },
		},
	},
	{
		"jdtls",
		{
			cmd = {
				"jdtls",
			},
			root_markers = { ".git", "pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle" },
			init_options = {
				jvm_args = {
					"-javaagent:" .. os.getenv("HOME") .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
				},
				workspace = os.getenv("HOME") .. "/.cache/jdtls/workspace",
				bundles = {
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar",
				},
			},
			filetypes = { "java" },
			settings = {
				java = {
					import = {
						granularity = "compilationUnit",
					},
					signatureHelp = {
						enabled = true,
					},
					extractMethod = {
						enabled = true,
					},
				},
			},
		},
	},
	{
		"pyright",
		{
			settings = {
				python = {
					pythonPath = function()
						local venv = os.getenv("VIRTUAL_ENV")
						if venv then
							return venv .. "/bin/python"
						end
						return nil
					end,
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
						typeCheckingMode = "basic",
						diagnosticSeverityOverrides = {
							reportUnusedExpression = "none",
						},
					},
				},
			},
			cmd = { "pyright-langserver", "--watch", "--stdio" },
			filetypes = { "python" },
			root_markers = { ".git" },
		},
	},
}
for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	if config then
		vim.lsp.config(name, config)
	end
	vim.lsp.enable(name)
end
