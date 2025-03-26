return {
	{
		"GCBallesteros/jupytext.nvim",
		config = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvimtools/hydra.nvim",
		},
		ft = { "quarto", "markdown" },
		opts = {
			lspFeatures = {
				-- NOTE: put whatever languages you want here:
				languages = { "r", "python" },
				chunks = "all",
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "ueberzug",
		},
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_auto_open_output = false
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
				{
					"<localleader>mo",
					mode = "n",
					":noautocmd MoltenEnterOutput<CR>",
					{ desc = "open output window", silent = true },
				},
				{
					"<localleader>mh",
					mode = "n",
					":MoltenHideOutput<CR>",
					{ desc = "close output window", silent = true },
				},
				{
					"<localleader>md",
					mode = "n",
					":MoltenDelete<CR>",
					{ desc = "delete Molten cell", silent = true },
				},
			},
		},
	},
}
