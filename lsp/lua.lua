vim.lsp.config["lua_ls"] = {
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
}
