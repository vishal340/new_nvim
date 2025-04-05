return {
	{
		"gcballesteros/jupytext.nvim",
		opts = {
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
			lspfeatures = {
				-- note: put whatever languages you want here:
				languages = { "r", "python", "julia" },
				chunks = "all",
				diagnostics = {
					enabled = true,
					triggers = { "bufwritepost" },
				},
				completion = {
					enabled = true,
				},
			},
			coderunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "ueberzug",
			processor = "magick_cli",
		},
	},
	{
		"benlubas/molten-nvim",
		event = "VeryLazy",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":updateremoteplugins",
		init = function()
			-- these are examples, not defaults. please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_auto_open_output = true
		end,
		keys = {
			{
				"<localleader>meo",
				mode = "n",
				":MoltenEvaluateOperator<cr>",
				{ desc = "evaluate operator", silent = true },
			},
			{
				"<localleader>mel",
				mode = "n",
				":MoltenEvaluateLine<cr>",
				{ desc = "eval line", silent = true },
			},
			{
				"<localleader>mec",
				mode = "n",
				":MoltenReevaluateCell<cr>",
				{ desc = "re-eval cell", silent = true },
			},
			{
				"<localleader>me",
				mode = "v",
				":<c-u>MoltenEvaluateVisual<cr>gv",
				{ desc = "execute visual selection", silent = true },
			},
			{
				"<localleader>mo",
				mode = "n",
				":noautocmd MoltenEnterOutput<cr>",
				{ desc = "open output window", silent = true },
			},
			{
				"<localleader>mh",
				mode = "n",
				":MoltenHideOutput<cr>",
				{ desc = "close output window", silent = true },
			},
			{
				"<localleader>md",
				mode = "n",
				":MoltenDelete<cr>",
				{ desc = "delete molten cell", silent = true },
			},
			{
				"<localleader>mi",
				mode = "n",
				function()
					local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
					if venv ~= nil then
						-- in the form of /home/benlubas/.virtualenvs/VENV_NAME
						venv = string.match(venv, "/.+/(.+)")
						vim.cmd(("MoltenInit %s"):format(venv))
					else
						vim.cmd("MoltenInit python3")
					end
				end,
				{ desc = "Initialize Molten for python3", silent = true },
			},
		},
	},
}
