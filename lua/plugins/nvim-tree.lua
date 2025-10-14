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
				width = 25,
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
