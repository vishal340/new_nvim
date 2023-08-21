return {
	'mhinz/vim-startify',
	init = function()
		vim.api.nvim_create_autocmd('TabNewEntered', {
			command = 'if bufname("%") == "" | silent! Startify | endif', nested = true
		})
	end,
}
