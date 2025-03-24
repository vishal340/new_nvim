return {
	{
		"nvimtools/hydra.nvim",
		config = function()
			-- create hydras in here
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		-- ft = { "python" },
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"3rd/image.nvim",
		opts = {},
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		-- ft = { "python" },
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
	},
}
