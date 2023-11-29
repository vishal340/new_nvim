return {
	'stevearc/conform.nvim',
	opts = {
		formatters_by_ft = {
			cpp = { "clang_format" },
			c = { "clang_format" },
			java = { "clang_format" },
			python = { "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			postgres = { "sqlfmt" },
			mysql = { "sqlfmt" },
			markdown = { "prettierd" },
			lua = { "stylua" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
	-- config = function()
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		pattern = "*",
	-- 		callback = function(args)
	-- 			require("conform").format({ bufnr = args.buf })
	-- 		end,
	-- 	})
	-- end
}
