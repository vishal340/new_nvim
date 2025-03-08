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
		dependencies = { "rmagatti/logger.nvim" },
		event = "BufEnter",
		config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
		keys = {
			{
				"<localleader>so",
				mode = { "n" },
				function()
					vim.cmd("SymbolsOutline")
				end,
			},
		},
	},
	{
		"folke/neodev.nvim",
		opts = {},
		event = "LspAttach",
		ft = "lua",
	},
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
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown", "org" },
	},
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
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("gitlinker").setup()
		end,
	},
}
