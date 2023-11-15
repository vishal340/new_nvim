return {
	'stevearc/conform.nvim',
	opts = {
		formatters_by_ft = {
			cpp = { "clang-format" },
			c = { "clang-format" },
			python = { "black" },
			java = { "clang_format" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			rust = { "rustfmt" },
			go = { "gofmt" },
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
