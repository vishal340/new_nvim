return {
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	{
		"onsails/lspkind.nvim",
		event = "LspAttach",
	},
	"nvim-lua/plenary.nvim",
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		opts = {},
	},
	{
		"folke/neodev.nvim",
		opts = {},
		event = "LspAttach",
		ft = "lua",
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
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		event = "LspAttach",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
	{
		"mfussenegger/nvim-jdtls",
		event = "LspAttach",
		ft = "java",
	},
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
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {
			toggle = true,
		},
	},
	"romainl/vim-qf",
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			autochdir = true,
			direction = "float",
		},
	},
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		lazy = true,
		dependencies = {
			"akinsho/toggleterm.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = true,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		opts = {},
	},
}
