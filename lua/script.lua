local id3 = vim.api.nvim_create_augroup("newtab", { clear = true })
vim.api.nvim_create_autocmd('TabNewEntered', {
	command = "if bufname('%') == '' | silent! Startify | endif",
	group = id3
})
--The below 2 autocmd close any terminal and nerdtree window if there are no windows in that tabpage

local capture = ""
local id2 = vim.api.nvim_create_augroup("cmdline", { clear = true })
vim.api.nvim_create_autocmd('CmdlineLeave', {
	callback = function()
		capture = vim.fn.getcmdline()
	end,
	group = id2
})

local function auto_close(cur, cmd)
	for x = 1, vim.fn.winnr('$') do
		if x ~= cur and string.match(vim.fn.bufname(vim.fn.winbufnr(x)), ".*%.[a-zA-Z]+$") then
			return
		end
	end
	if vim.fn.tabpagenr('$') > 1 and not string.find(cmd, "a") then
		vim.cmd "tabclose"
	else
		vim.cmd "quitall"
	end
end

local id1 = vim.api.nvim_create_augroup("termclose", { clear = true })
vim.api.nvim_create_autocmd('QuitPre', {
	callback = function()
		if string.match(vim.fn.bufname(vim.fn.winbufnr(0)), ".*%.[a-zA-Z]+$") and vim.fn.winnr('$') > 1 then
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
