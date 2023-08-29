return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"S",
			mode = { "n", "x", "o" },
			function() require("flash").jump() end,
			desc =
			"Flash"
		},
		{
			"*",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					pattern = vim.fn.expand("<cword>"),
				})
			end,
			desc =
			"Flash word search"
		},
		{
			"<localleader>s",
			mode = { "n", "o", "x" },
			function() require("flash").treesitter() end,
			desc =
			"Flash Treesitter"
		},
		{
			"r",
			mode = "o",
			function() require("flash").remote() end,
			desc =
			"Remote Flash"
		},
		{
			"R",
			mode = { "o", "x" },
			function() require("flash").treesitter_search() end,
			desc =
			"Treesitter Search"
		},
		{
			"<C-s>",
			mode = { "c" },
			function() require("flash").toggle() end,
			desc =
			"Toggle Flash Search"
		},
	},
}
