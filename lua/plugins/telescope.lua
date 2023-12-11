return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"debugloop/telescope-undo.nvim",
	},
	optional = true,
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<M-t>"] = actions.select_tab,
						["<M-h>"] = actions.select_horizontal,
						["<M-v>"] = actions.select_vertical,
						["<M-d>"] = actions.delete_buffer,
						["<M-q>"] = actions.send_selected_to_qflist,
						["<M-a>"] = actions.select_all,
					},
				},
			},
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
			extensions = {
				undo = {},
				fzf = {},
			},
		})
		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("undo")
	end,
}
