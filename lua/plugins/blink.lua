return {
	"saghen/blink.cmp",
	version = "*",
	dependecies = {
		"L3MON4D3/LuaSnip",
	},
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<Up>"] = {},
			["<Down>"] = {},
		},
		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true },
		},
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	-- config = function()
	-- 	vim.cmd(
	-- 		"autocmd FileType sql,mysql,postgres lua require('blink.cmp').setup.opts_extend={'sources.default','vim-dadbod-completion'})"
	-- 	)
	-- end,
}
