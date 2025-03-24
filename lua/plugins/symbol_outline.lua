return {
	"simrat39/symbols-outline.nvim",
	config = function()
		require("symbols-outline").setup()
	end,
	keys = {
		{
			"<localleader>so",
			mode = { "n" },
			function()
				vim.cmd("SymbolsOutline")
			end,
		},
	},
}
