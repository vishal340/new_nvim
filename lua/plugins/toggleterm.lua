return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		autochdir = true,
		direction = "float",
		-- Preserve environment variables from the terminal session
		env = vim.fn.environ(),
	},
}
