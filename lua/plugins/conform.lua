return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	opts = {
		quite = true,
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
			sh = { "shfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)
		conform.formatters.prettier = {
			prepend_args = function()
				return {
					"--config-precedence",
					"prefer-file",
				}
			end,
		}
	end,
}
