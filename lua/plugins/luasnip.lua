return {
	'L3MON4D3/LuaSnip', 
	lazy = true,
	version = "2.*",
	build = "make install_jsregexp",
	init = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
	end,
}

