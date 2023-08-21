return {
	"folke/which-key.nvim",
	init = function()
		require("which-key").register({ prefix = { "leader", "localleader" } })
	end,
}

