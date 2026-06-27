local id3 = vim.api.nvim_create_augroup("newtab", { clear = true })
vim.api.nvim_create_autocmd("TabNewEntered", {
	command = "if bufname('%') == '' | silent! Startify | endif",
	group = id3,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cpp", "c" },
	callback = function()
		vim.opt_local.keywordprg = "cppman"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.keywordprg = "python3 -m pydoc"
	end,
})
