local platform = require("utils.platform")

vim.lsp.config("*", {
	on_attach = require("lsp.on_attach"),
})

local clangd_cmd = {
	"clangd",
	"--background-index",
	"--clang-tidy",
	"--function-arg-placeholders",
	"--fallback-style=llvm",
	"--header-insertion=iwyu",
	"--all-scopes-completion",
	"--completion-style=detailed",
}

local gxx_driver = platform.newest_gxx_driver()
if gxx_driver then
	table.insert(clangd_cmd, "--query-driver=" .. gxx_driver)
end

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
			single_file_support = true,
			root_markers = {
				"Makefile",
				"configure.ac",
				"configure.in",
				"config.h.in",
				"build.ninja",
				"compile_commands.json",
				"compile_flags.txt",
			},
			cmd = clangd_cmd,
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
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
							vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
						},
						checkThirdParty = false,
					},
					telemetry = { enable = false },
					completion = { callSnippet = "Replace" },
				},
			},
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".git", ".luarc.json" },
		},
	},
	{
		"pyright",
		{
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
						typeCheckingMode = "basic",
						diagnosticSeverityOverrides = {
							reportUnusedExpression = "none",
						},
					},
				},
			},
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
		},
	},
}

for _, lsp in ipairs(lsps) do
	local name, config = lsp[1], lsp[2]
	if config then
		vim.lsp.config(name, config)
	end
	vim.lsp.enable(name)
end
