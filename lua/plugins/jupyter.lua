return {
	{
		"GCBallesteros/jupytext.nvim",
		config = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
		lazy = true,
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
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
		keys = {
			{
				"<localleader>meo",
				mode = "n",
				":MoltenEvaluateOperator<CR>",
				{ desc = "evaluate operator", silent = true },
			},
			{
				"<localleader>mec",
				mode = "n",
				":MoltenEvaluateCell<CR>",
				{ desc = "re-eval cell", silent = true },
			},
			{
				"<localleader>me",
				mode = "v",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ desc = "execute visual selection", silent = true },
			},
		},
	},
}
