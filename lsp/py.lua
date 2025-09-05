vim.lsp.config["pyright"] = {
	settings = {
		python = {
			analysis = {
				diagnosticSeverityOverrides = {
					reportUnusedExpression = "none",
				},
			},
		},
	},
}
