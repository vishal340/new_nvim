local id3 = vim.api.nvim_create_augroup("newtab", { clear = true })
vim.api.nvim_create_autocmd("TabNewEntered", {
	command = "if bufname('%') == '' | silent! Startify | endif",
	group = id3,
})

local id1 = vim.api.nvim_create_augroup("termclose", { clear = true })
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		if string.match(vim.fn.bufname(vim.fn.winbufnr(0)), ".*%.[a-zA-Z]+$") and vim.fn.winnr("$") > 1 then
			auto_close(vim.fn.winnr(), capture)
		end
	end,
	group = id1,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
