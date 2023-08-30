vim.cmd([[
	augroup vimrc
	  au BufReadPre * setlocal foldmethod=indent
	  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END
]])
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

local function term_auto_close(cur, cmd)
	local l = vim.api.nvim_tabpage_list_wins(0)
	for i, x in pairs(l) do
		if vim.fn.winbufnr(x) ~= cur and string.match(vim.fn.bufname(vim.fn.winbufnr(x)), ".*%.[a-zA-Z]+$") then
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
		term_auto_close(vim.fn.winbufnr(0), capture)
	end,
	group = id1,
})
