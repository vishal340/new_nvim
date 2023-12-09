return {
	"p00f/godbolt.nvim",
	lazy = true,
	config = function()
		vim.g.godbolt_exec = 1
		require("godbolt").setup({
			quickfix = {
				enable = true,
				auto_open = true,
			},
			url = "https://godbolt.org",
		})
	end,
}
