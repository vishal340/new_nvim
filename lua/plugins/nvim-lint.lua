return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		require('lint').linters_by_ft = {
			cmake = { 'cmakelint' },
			cpp = { 'cpplint' },
			javascript = { 'eslint_d' },
			typescript = { 'eslint_d' },
			python = { 'ruff-lsp' },
			go = { 'golangcli-lint' },
			docker = { 'hadolint' },
			bash = { 'shellcheck' },
			vimscript = { 'vint' },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end
}
