vim.lsp.config["jdtls"] = {
	init_options = {
		jvm_args = {},
		workspace = "/home/user/.cache/jdtls/workspace",
		bundles = {
			"$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar",
		},
	},
}
