return {
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'saadparwaiz1/cmp_luasnip',
	{ "petertriho/cmp-git", dependecies = "nvim-lua/plenary.nvim" ,opts = {}},
	"onsails/lspkind.nvim",
	"nvim-lua/plenary.nvim",
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	'rmagatti/goto-preview',
	{ 'kevinhwang91/nvim-bqf', ft = 'qf' },
	{ "rcarriga/nvim-dap-ui", dependecies = { "mfussenegger/nvim-dap" } },
	{
		'folke/neodev.nvim',
		opts = {
			library = { plugins = { "nvim-dap-ui" }, types = true }
		}
	},
	'jbyuki/one-small-step-for-vimkind',
	"rafamadriz/friendly-snippets",
	'nvim-treesitter/nvim-treesitter-textobjects',
	{ 
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	"tpope/vim-repeat",
	{
		"ur4ltz/surround.nvim",
		opts = {mappings_style = "surround"},
	},
	{
		'numToStr/Comment.nvim',
		opts = {}
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = "markdown",
	},
	"mfussenegger/nvim-jdtls",
	'lewis6991/gitsigns.nvim',
	"tpope/vim-fugitive",
	{
		'ruifm/gitlinker.nvim',
		dependecies = 'nvim-lua/plenary.nvim',
	},
	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
	},
	{ 'sindrets/diffview.nvim', dependecies = 'nvim-lua/plenary.nvim' },
	{
		'mattn/vim-gist',
		dependecies = { 'mattn/webapi-vim' }
	},
	"Fildo7525/pretty_hover",
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		opts= { keys = 'etovxqpdygfblzhckisuran' }
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependecies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
	   	},
	},
	"Pocco81/HighStr.nvim",
	"tpope/vim-dadbod",
	'kristijanhusak/vim-dadbod-ui',
	'rhysd/vim-grammarous',
	'mbbill/undotree',
 	--'norcalli/nvim-colorizer.lua',
}
