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
	{ 'kevinhwang91/nvim-bqf',       ft = 'qf' },
	{
		"rcarriga/nvim-dap-ui",
		event = 'VeryLazy',
		dependecies = { "mfussenegger/nvim-dap" },
		opts = {}
	},
	{
		'folke/neodev.nvim',
		event = "LspAttach",
		opts = {
			library = { plugins = { "nvim-dap-ui" }, types = true, lspconfig = true }
		}
	},
	'jbyuki/one-small-step-for-vimkind',
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
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = "markdown",
	},
	"mfussenegger/nvim-jdtls",
	'lewis6991/gitsigns.nvim',
	"tpope/vim-fugitive",
	{
		'pwntester/octo.nvim',
		event = "VeryLazy",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
	},
	'sindrets/diffview.nvim',
	{
		'mattn/vim-gist',
		event = "VeryLazy",
		dependecies = { 'mattn/webapi-vim' }
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {}
	},
	"Pocco81/HighStr.nvim",
	{
		"tpope/vim-dadbod",
		lazy = true
	},
	{ 'kristijanhusak/vim-dadbod-ui' },
	'rhysd/vim-grammarous',
	'mbbill/undotree',
	--'norcalli/nvim-colorizer.lua',
}
