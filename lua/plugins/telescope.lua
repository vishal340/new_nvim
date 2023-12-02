return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	optional = true,
	opts = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob",
			"!**/.git/*",
			"--trim",
		},
		preview = {
			filesize_limit = 0.1,
		},
	},
	config = function()
		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("fzf")
	end,
}
