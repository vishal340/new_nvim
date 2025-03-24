return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			autochdir = true,
			direction = "float",
		},
	},
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		lazy = true,
		dependencies = {
			"akinsho/toggleterm.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = true,
	},
}
