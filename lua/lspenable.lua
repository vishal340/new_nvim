local lsps = {
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
}
for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	vim.lsp.enable(name)
	if config then
		vim.lsp.config(name, config)
	end
end
