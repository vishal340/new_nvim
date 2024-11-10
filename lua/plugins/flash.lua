return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"*",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					pattern = vim.fn.expand("<cword>"),
				})
			end,
			desc = "Flash word search",
		},
		{
			"<localleader>ft",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"<localleader>fr",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
	},
}
