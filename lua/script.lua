vim.cmd([[
	augroup vimrc
	  au BufReadPre * setlocal foldmethod=indent
	  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END

	if !exists("g:skipview_files")
		 let g:skipview_files = []
	endif
	function! MakeViewCheck()
		 if &l:diff | return 0 | endif
		 if &buftype != '' | return 0 | endif
		 if expand('%') =~ '\[.*\]' | return 0 | endif
		 if empty(glob(expand('%:p'))) | return 0 | endif
		 if &modifiable == 0 | return 0 | endif
		 if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
		 if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif
		 let file_name = expand('%:p')
		 for ifiles in g:skipview_files
			  if file_name =~ ifiles
					return 0
			  endif
		 endfor
		 return 1
	endfunction
	augroup AutoView
		 autocmd!
		 " Autosave & Load Views.
		 autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
		 autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
	augroup END
]])

local function term_auto_close(cur)
	local l = vim.api.nvim_tabpage_list_wins(0)
	for i, x in pairs(l) do
		if vim.fn.winbufnr(x) ~= cur and string.match(vim.fn.bufname(vim.fn.winbufnr(x)), ".*%.[a-zA-Z]+$") then
			-- vim.cmd"quit"
			return
		end
	end
	if vim.fn.tabpagenr('$') > 1 then
		vim.cmd"tabclose"
	else
		vim.cmd"quitall"
	end
end

local id1 = vim.api.nvim_create_augroup("termclose", {clear = true})
vim.api.nvim_create_autocmd('QuitPre', {
	callback = function ()
		term_auto_close(vim.fn.winbufnr(0))
	end,
	group = id1,
})
