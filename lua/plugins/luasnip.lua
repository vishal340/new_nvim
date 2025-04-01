return {
	"L3MON4D3/LuaSnip",
	event = "LspAttach",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*",
	build = "make install_jsregexp",
	init = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
	end,
}
