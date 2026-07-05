return {
	"ruifm/gitlinker.nvim",
	lazy = true,
	cmd = "GitLink",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("gitlinker").setup()
	end,
}
