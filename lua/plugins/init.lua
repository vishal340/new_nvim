return {
	"nvim-lua/plenary.nvim",
	"rafamadriz/friendly-snippets",
	{
		"tpope/vim-repeat",
		event = "InsertEnter",
	},
	{
		"ur4ltz/surround.nvim",
		event = "InsertEnter",
		opts = { mappings_style = "surround" },
	},
	{
		"itchyny/vim-gitbranch",
		event = "VeryLazy",
	},
	{
		"mhinz/vim-startify",
		-- cmd = "Startify",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			watch_gitdir = { enable = true, follow_files = false },
			update_debounce = 200,
			current_line_blame = false,
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gwrite", "Ggrep", "GMove", "GDelete" },
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
		},
	},
	{
		"mattn/vim-gist",
		cmd = { "Gist", "GistList" },
	},
	"mattn/webapi-vim",
	"romainl/vim-qf",
	{
		"echasnovski/mini.files",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "text", "markdown", "org" },
		config = function()
			vim.cmd("silent TableModeEnable")
		end,
	},
	"direnv/direnv.vim",
}
