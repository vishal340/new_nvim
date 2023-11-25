local keymap = vim.keymap.set

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap('n', '<leader>gtD', '<cmd>tab split| lua vim.lsp.buf.declaration()<cr>', bufopts)
	keymap('n', '<leader>gvD', '<cmd>vs| lua vim.lsp.buf.declaration()<cr>', bufopts)
	keymap('n', '<leader>ghD', '<cmd>sp| lua vim.lsp.buf.declaration()<cr>', bufopts)
	keymap('n', '<leader>gfd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', bufopts)
	keymap('n', '<leader>gtd', '<cmd>tab split| lua vim.lsp.buf.definition()<cr>', bufopts)
	keymap('n', '<leader>gvd', '<cmd>vs| lua vim.lsp.buf.definition()<cr>', bufopts)
	keymap('n', '<leader>ghd', '<cmd>sp| lua vim.lsp.buf.definition()<cr>', bufopts)
	keymap('n', '<leader>gfi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', bufopts)
	keymap('n', '<leader>gti', '<cmd>tab split| lua vim.lsp.buf.implementation()<cr>', bufopts)
	keymap('n', '<leader>gvi', '<cmd>vs| lua vim.lsp.buf.implementation()<cr>', bufopts)
	keymap('n', '<leader>ghi', '<cmd>sp| lua vim.lsp.buf.implementation()<cr>', bufopts)
	keymap('n', '<leader>gi', function()
		require("telescope.builtin").lsp_implementations()
	end, bufopts)
	keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
	keymap('n', '<leader>gd', function()
		require('telescope.builtin').lsp_definitions()
	end, bufopts)
	keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
	keymap('n', '<leader>gfr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', bufopts)
	keymap('n', '<leader>gr', function()
		require("telescope.builtin").lsp_references()
	end, bufopts)
	keymap('n', '<leader>ll', function()
		require("telescope.builtin").treesitter()
	end, bufopts)
	keymap('n', '<leader>ic', function()
		require("telescope.builtin").lsp_incoming_calls()
	end, bufopts)
	keymap('n', '<leader>oc', function()
		require("telescope.builtin").lsp_outgoing_calls()
	end, bufopts)
	keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<cr>', bufopts)

	keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<cr>', bufopts)
	keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', bufopts)
	keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>', bufopts)
	keymap('n', '<leader>dl', function()
		require("telescope.builtin").diagnostics()
	end, bufopts)
	keymap('n', '<leader>dh', '<cmd>lua vim.diagnostic.hide()<cr>', bufopts)
	keymap('n', '<leader>ds', '<cmd>lua vim.diagnostic.show()<cr>', bufopts)
	keymap('n', '<leader>gft', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', bufopts)
	keymap('n', 'K', '<cmd>lua require("pretty_hover").hover()<cr>', bufopts)
	-- keymap('n', '<leader>ih', function()
	-- 	if vim.lsp.inlay_hint.is_enabled(0) then
	-- 		vim.lsp.inlay_hint.enable(0, false)
	-- 	else
	-- 		vim.lsp.inlay_hint.enable(0, true)
	-- 	end
	-- end)
end

return {
	'neovim/nvim-lspconfig', -- Configurations for Nvim LSP
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
	},
	-- opts = {
	-- 	inlay_hint = { enable = true },
	-- },
	init = function()
		local lspconfig = require('lspconfig')
		local lsp_defaults = lspconfig.util.default_config
		lsp_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lsp_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)
		lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true

		lsp_defaults.on_attach = on_attach
		lspconfig.ruff_lsp.setup {
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = {},
				}
			}
		}
		lspconfig.eslint.setup({
			on_attach = function(_, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})
		lspconfig.jsonls.setup {}
		lspconfig.rust_analyzer.setup {}
		lspconfig.taplo.setup {}

		lspconfig.clangd.setup {
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--query-driver=/usr/lib/llvm-13/bin/clang++-15",
				"--all-scopes-completion",
				"--completion-style=detailed",
			}
		}

		lspconfig.gopls.setup {}

		lspconfig.lua_ls.setup({
			single_file_support = true,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT',
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { 'vim' },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.env.VIMRUNTIME,
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
					completion = {
						callSnippet = "Replace"
					}
				}
			}
		})

		lspconfig.vimls.setup {}
		lspconfig.bashls.setup {}
		lspconfig.html.setup {}
		lspconfig.cmake.setup {}
		lspconfig.dockerls.setup {}
		lspconfig.docker_compose_language_service.setup {}
		lspconfig.gradle_ls.setup {}

		lspconfig.ltex.setup {
			settings = {
				ltex = {
					language = "en-us",
				},
			},
		}
	end
}
