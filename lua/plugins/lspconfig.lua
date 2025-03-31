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

local on_attach = function(_, bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
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
	keymap("n", "<leader>ih", function()
		if vim.lsp.inlay_hint.is_enabled(0) then
			vim.lsp.inlay_hint.enable(0, false)
		else
			vim.lsp.inlay_hint.enable(0, true)
		end
	end)
end

return {
	{
		"neovim/nvim-lspconfig", -- Configurations for Nvim LSP
		event = "LspAttach",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		init = function()
			local lspconfig = require("lspconfig")
			local lsp_defaults = lspconfig.util.default_config
			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
			lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true

			lsp_defaults.on_attach = on_attach
			lspconfig.ruff.setup({
				init_options = {
					settings = {
						-- Any extra CLI arguments for `ruff` go here.
						args = {},
					},
				},
			})

			lspconfig.clangd.setup({
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(
						"Makefile",
						"configure.ac",
						"configure.in",
						"config.h.in",
						"build.ninja"
					)(fname) or require("lspconfig.util").root_pattern(
						"compile_commands.json",
						"compile_flags.txt"
					)(fname) or require("lspconfig.util").find_git_ancestor(fname)
				end,
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--header-insertion=iwyu",
					-- "--query-driver=/usr/lib/llvm-13/bin/clang++-15",
					"--all-scopes-completion",
					"--completion-style=detailed",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			})

			lspconfig.lua_ls.setup({
				single_file_support = true,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.env.VIMRUNTIME,
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			require("lspconfig").ltex_plus.setup({})
			lspconfig.sqlls.setup({
				filetypes = { "sql", "mysql", "postgres" },
			})

			lspconfig.jdtls.setup({
				init_options = {
					jvm_args = {},
					workspace = "/home/user/.cache/jdtls/workspace",
					bundles = {
						"$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.47.0.jar",
					},
				},
			})
			lspconfig.gopls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.yamlls.setup({})
			lspconfig.rust_analyzer.setup({})
			lspconfig.taplo.setup({})
			lspconfig.vimls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.html.setup({})
			lspconfig.htmx.setup({})
			lspconfig.cmake.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.gradle_ls.setup({})
		end,
	},
}
