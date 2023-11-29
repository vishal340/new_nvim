return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		event = { "BufEnter *.py", "BufEnter *.ipynb" },
		dependencies = {
			"3rd/image.nvim",
			event = { "BufEnter *.py", "BufEnter *.ipynb" },
			opts = {
				-- backend = "xterm", -- whatever backend you would like to use
				max_width = 100,
				max_height = 12,
				max_height_window_percentage = math.huge,
				max_width_window_percentage = math.huge,
				window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			},
		},
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = true
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		event = "BufEnter *.ipynb",
		config = true,
	}
}
