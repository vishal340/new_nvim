return {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	{
		"petertriho/cmp-git",
		opts = {},
	},
	"onsails/lspkind.nvim",
	"nvim-lua/plenary.nvim",
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		opts = {},
	},
	{ "folke/neodev.nvim", opts = {} },
	"rafamadriz/friendly-snippets",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	"tpope/vim-repeat",
	{
		"ur4ltz/surround.nvim",
		opts = { mappings_style = "surround" },
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
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
	"mfussenegger/nvim-jdtls",
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	"tpope/vim-fugitive",
	"sindrets/diffview.nvim",
	{
		"mattn/vim-gist",
		lazy = true,
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},
	{
		"AckslD/messages.nvim",
		opts = {},
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
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
}
