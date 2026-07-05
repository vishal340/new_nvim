return {
	"sheng-tse/jupynvim",
	lazy = true,
	event = { "BufReadPre *.ipynb", "BufReadCmd *.ipynb" },
	build = function(plugin)
		local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
		install.run(plugin)
	end,
	config = function()
		require("jupynvim").setup({
			log_level = "info",
			image_renderer = "placeholder", -- "placeholder", "kitty", or "chafa"
			-- Keep <leader>e / <leader>E for mini.files and nvim-tree (see mapping.lua).
			-- Remote explorer: :JupynvimExplorer when an SSH session is active.
			explorer_keys = {},
		})
	end,
}
