return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local luasnip = require("luasnip")
		luasnip.config.setup({
			updateevents = "TextChanged,TextChangedI",
			delete_check_events = "TextChanged",
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})
		require("luasnip.loaders.from_lua").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
			override_priority = 2000,
		})

		-- VSCode snippets (e.g. comp with $0): detach as soon as $0 is reached.
		-- LuaSnip already clears session.current_nodes[buf] on BufDelete/BufWipeout.
		vim.api.nvim_create_autocmd("User", {
			pattern = "LuasnipExitNodeEnter",
			callback = function()
				local ft = vim.bo.filetype
				if ft ~= "cpp" and ft ~= "c" then
					return
				end
				local node = luasnip.session.event_node
				if node and node.pos == 0 and luasnip.in_snippet() then
					luasnip.unlink_current()
				end
			end,
		})
	end,
}
