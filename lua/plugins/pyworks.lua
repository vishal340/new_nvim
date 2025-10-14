return {
	{
		"jeryldev/pyworks.nvim",
		dependencies = {
			{
				"GCBallesteros/jupytext.nvim",
				config = true, -- IMPORTANT: This ensures jupytext.setup() is called!
			},
			{
				"benlubas/molten-nvim", -- Required: Code execution
				build = ":UpdateRemotePlugins", -- IMPORTANT: Required for Molten to work
			},
			"3rd/image.nvim", -- Required: Image display
		},
		config = function()
			require("pyworks").setup({
				-- Pyworks auto-configures everything with proven settings!
				-- Just specify any preferences:
				python = {
					use_uv = true, -- Use uv for faster package installation
				},
				image_backend = "kitty", -- or "ueberzug" for other terminals

				-- Optional: Skip auto-configuration of specific dependencies
				-- skip_molten = false,
				-- skip_jupytext = false,
				-- skip_image = false,
				-- skip_keymaps = false,
			})
		end,
		lazy = false, -- Load immediately for file detection
		priority = 100, -- Load early
	},
}
