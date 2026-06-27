local jdtls = require("jdtls")
local mason_data = vim.fn.stdpath("data") .. "/mason/packages"
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

if vim.fn.executable(mason_bin) ~= 1 then
	vim.notify("jdtls not found; run :MasonInstall jdtls", vim.log.levels.WARN)
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

local lombok = mason_data .. "/jdtls/lombok.jar"
local cmd = { mason_bin }
if vim.fn.filereadable(lombok) == 1 then
	table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok)
end

local bundles = {}
vim.list_extend(
	bundles,
	vim.fn.glob(mason_data .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
)
vim.list_extend(bundles, vim.fn.glob(mason_data .. "/java-test/extension/server/*.jar", true, true))

local ok, blink_cmp = pcall(require, "blink.cmp")
local capabilities = ok and blink_cmp.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

local config = {
	name = "jdtls",
	cmd = cmd,
	root_dir = vim.fs.root(0, {
		".git",
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
	}),
	on_attach = require("lsp.on_attach"),
	capabilities = capabilities,
	settings = {
		java = {
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			signatureHelp = { enabled = true },
			extractMethod = { enabled = true },
			import = { granularity = "compilationUnit" },
			format = { enabled = false },
			configuration = { updateBuildConfiguration = "interactive" },
			inlayHints = { parameterNames = { enabled = "all" } },
		},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
	init_options = {
		bundles = bundles,
	},
}

jdtls.start_or_attach(config)
