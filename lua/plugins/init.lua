return {
	"nvim-lua/plenary.nvim",
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	"rafamadriz/friendly-snippets",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"tpope/vim-repeat",
		event = "InsertEnter",
	},
	{
		"ur4ltz/surround.nvim",
		event = "InsertEnter",
		opts = { mappings_style = "surround" },
	},
	"itchyny/vim-gitbranch",
	"mhinz/vim-startify",
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	ft = "java",
	-- 	event = "LspAttach",
	-- },
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	"tpope/vim-fugitive",
	{
		"sindrets/diffview.nvim",
		lazy = true,
	},
	{
		"mattn/vim-gist",
		lazy = true,
	},
	"romainl/vim-qf",
	{
		"echasnovski/mini.files",
		version = "*",
		opts = {},
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "text", "markdown", "org" },
		config = function()
			vim.cmd("silent TableModeEnable")
		end,
	},
	{
		"lervag/vimtex",
		ft = "tex",
	},
}
