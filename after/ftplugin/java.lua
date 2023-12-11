vim.cmd([[
setlocal tabstop=2
setlocal shiftwidth=2
]])

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

local diagnostic_list_from_git_root = function()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")
		return vim.v.shell_error == 0
	end
	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end
	local opt = {}
	if is_git_repo() then
		opt = {
			cwd = get_git_root(),
		}
	end
	builtin.diagnostics(opt)
end

local keys = function(_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap("n", "<leader>gtD", "<cmd>tab split| lua vim.lsp.buf.declaration()<cr>", bufopts)
	keymap("n", "<leader>gvD", "<cmd>vs| lua vim.lsp.buf.declaration()<cr>", bufopts)
	keymap("n", "<leader>ghD", "<cmd>sp| lua vim.lsp.buf.declaration()<cr>", bufopts)
	keymap("n", "<leader>gfd", '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', bufopts)
	keymap("n", "<leader>gtd", "<cmd>tab split| lua vim.lsp.buf.definition()<cr>", bufopts)
	keymap("n", "<leader>gvd", "<cmd>vs| lua vim.lsp.buf.definition()<cr>", bufopts)
	keymap("n", "<leader>ghd", "<cmd>sp| lua vim.lsp.buf.definition()<cr>", bufopts)
	keymap("n", "<leader>gfi", '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', bufopts)
	keymap("n", "<leader>gfr", '<cmd>lua require("goto-preview").goto_preview_references()<CR>', bufopts)
	keymap("n", "<leader>gti", "<cmd>tab split| lua vim.lsp.buf.implementation()<cr>", bufopts)
	keymap("n", "<leader>gvi", "<cmd>vs| lua vim.lsp.buf.implementation()<cr>", bufopts)
	keymap("n", "<leader>ghi", "<cmd>sp| lua vim.lsp.buf.implementation()<cr>", bufopts)
	keymap("n", "<leader>gi", function()
		builtin.lsp_implementations()
	end, bufopts)
	keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufopts)
	keymap("n", "<leader>gd", function()
		builtin.lsp_definitions()
	end, bufopts)
	keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", bufopts)
	keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", bufopts)
	keymap("n", "<leader>ll", function()
		builtin.treesitter()
	end, bufopts)
	keymap("n", "<leader>lic", function()
		builtin.lsp_incoming_calls()
	end, bufopts)
	keymap("n", "<leader>loc", function()
		builtin.lsp_outgoing_calls()
	end, bufopts)
	keymap("n", "<leader>bf", "<cmd>lua vim.lsp.buf.formatting()<cr>", bufopts)

	keymap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<cr>", bufopts)
	keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufopts)
	keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufopts)
	keymap("n", "<leader>dl", function()
		diagnostic_list_from_git_root()
	end, bufopts)
	keymap("n", "<leader>dh", "<cmd>lua vim.diagnostic.hide()<cr>", bufopts)
	keymap("n", "<leader>ds", "<cmd>lua vim.diagnostic.show()<cr>", bufopts)
	keymap("n", "<leader>gft", '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', bufopts)
	keymap("n", "K", '<cmd>lua require("pretty_hover").hover()<cr>', bufopts)
	keymap("n", "<leader>ih", function()
		if vim.lsp.inlay_hint.is_enabled(0) then
			vim.lsp.inlay_hint.enable(0, false)
		else
			vim.lsp.inlay_hint.enable(0, true)
		end
	end)
end

local jdtls = require("jdtls")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
local workspace = os.getenv("HOME") .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	flags = {
		allow_incremental_sync = true,
	},
	capabilities = capabilities,
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"jdtls",
		"-data",
		workspace,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			home = "/usr/lib/jvm/java-17-openjdk-amd64/",
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			extendedClientCapabilities = extendedClientCapabilities,
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk-amd64/",
					},
				},
			},
			eclipse = {
				downloadSources = true,
			},
			gradle = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			references = {
				includeDecompiledSources = true,
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {
			"$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar",
		},
	},
}
config["on_attach"] = function(_, bufnr)
	jdtls.setup.add_commands()
	jdtls.setup_dap({ hotcodereplace = "auto" })
	keys(_, bufnr)
end
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
