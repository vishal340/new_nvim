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

	function DisableSyntaxTreesitter()
		 if exists(':TSBufDisable')
			  exec 'TSBufDisable autotag'
			  exec 'TSBufDisable highlight'
			  exec 'TSBufDisable incremental_selection'
			  exec 'TSBufDisable indent'
			  exec 'TSBufDisable playground'
			  exec 'TSBufDisable rainbow'
			  exec 'TSBufDisable refactor.highlight_definitions'
			  exec 'TSBufDisable refactor.navigation'
			  exec 'TSBufDisable refactor.smart_rename'
			  exec 'TSBufDisable refactor.highlight_current_scope'
			  exec 'TSBufDisable textobjects.swap'
			  " exec 'TSBufDisable textobjects.move'
			  exec 'TSBufDisable textobjects.lsp_interop'
			  exec 'TSBufDisable textobjects.select'
		 endif

		 set foldmethod=manual
	endfunction

	augroup BigFileDisable
		 autocmd!
		 autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
	augroup END
	]])

local capture=""
local id2 = vim.api.nvim_create_augroup("cmdline",{clear = true})
vim.api.nvim_create_autocmd('CmdlineLeave', {
	callback = function ()
		capture= vim.fn.getcmdline()
	end,
	group = id2
})

local function term_auto_close(cur,cmd)
	local l = vim.api.nvim_tabpage_list_wins(0)
	for i, x in pairs(l) do
		if vim.fn.winbufnr(x) ~= cur and string.match(vim.fn.bufname(vim.fn.winbufnr(x)), ".*%.[a-zA-Z]+$") then
			return
		end
	end
	if vim.fn.tabpagenr('$') > 1 and not string.find(cmd,"a") then
			vim.cmd"tabclose"
	else
		vim.cmd"quitall"
	end
end

local id1 = vim.api.nvim_create_augroup("termclose", {clear = true})
vim.api.nvim_create_autocmd('QuitPre', {
	callback = function ()
		term_auto_close(vim.fn.winbufnr(0),capture)
	end,
	group = id1,
})
