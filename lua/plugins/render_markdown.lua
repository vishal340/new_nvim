return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
	event = { "BufReadPost *.md", "BufNewFile *.md" },
	config = function()
		require("render-markdown").setup({
			highlight_code_blocks = true,
			languages = { "cpp", "python" },
			auto_enable = true,
			commands = {
				toggle = function()
					require("render-markdown").toggle()
				end,
				enable = function()
					require("render-markdown").enable()
				end,
				disable = function()
					require("render-markdown").disable()
				end,
			},
		})
	end,
}
