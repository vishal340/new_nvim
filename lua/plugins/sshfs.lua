return {
	"nosduco/remote-sshfs.nvim",
	lazy = true,
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("remote-sshfs").setup({})
		require("telescope").load_extension("remote-sshfs")
	end,
}
