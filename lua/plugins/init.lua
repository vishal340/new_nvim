return {
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'saadparwaiz1/cmp_luasnip',
	"onsails/lspkind.nvim",
	"nvim-lua/plenary.nvim",
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		opts = {}
	},
	{
		'rmagatti/goto-preview',
		event = "LspAttach",
		opts = {},
	},
	{ "folke/neodev.nvim", opts = {} },
	"rafamadriz/friendly-snippets",
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	"tpope/vim-repeat",
	{
		"ur4ltz/surround.nvim",
		opts = { mappings_style = "surround" },
	},
	{
		'numToStr/Comment.nvim',
		opts = {}
	},
	'mhinz/vim-startify',
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		event = "LspAttach",
		init = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = "markdown",
	},
	"mfussenegger/nvim-jdtls",
	{
		'lewis6991/gitsigns.nvim',
		opts = {}
	},
	"tpope/vim-fugitive",
	'sindrets/diffview.nvim',
	'mattn/webapi-vim',
	{
		'mattn/vim-gist',
		lazy = true,
		event = "VeryLazy",
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {}
	},
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})
		end
	},
	"Pocco81/HighStr.nvim",
	--'norcalli/nvim-colorizer.lua',
}
