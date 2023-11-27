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
			postgres = { "sqlfmt" },
			mysql = { "sqlfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
		formatters = {
			clang_format = {
			},
		},
	},
}
