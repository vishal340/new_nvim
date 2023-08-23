local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opt(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set('n', 't', api.node.open.tab, opt('Open: New Tab'))
	vim.keymap.set('n', 'v', api.node.open.vertical, opt('Open: Vertical Split'))
	vim.keymap.set('n', 'h', api.node.open.horizontal, opt('Open: Horizontal Split'))
end
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			on_attach = my_on_attach,
			sort_by = "case_sensitive",
			open_on_tab = true,
			view = {
				adaptive_size = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		}
	end,
}
