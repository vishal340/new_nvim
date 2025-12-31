return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				centralize_selection = false,
				cursorline = true,
				cursorlineopt = "both",
				debounce_delay = 15,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = true,
				signcolumn = "yes",
				width = 40,
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			filters = {
				dotfiles = false,
			},
		})
	end,
	keys = {
		{
			"<leader>E",
			mode = { "n" },
			"<cmd>NvimTreeToggle<cr>",
			desc = "nvimtree toggle",
		},
	},
}
