return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			cpp = { "clang_format" },
			c = { "clang_format" },
			java = { "clang_format" },
			python = { "black" },
			rust = { "rustfmt" },
			go = { "gofmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			postgres = { "sqlfmt" },
			mysql = { "sqlfmt" },
			markdown = { "prettier" },
			lua = { "stylua" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
}
