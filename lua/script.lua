vim.api.nvim_create_autocmd('BufEnter', {
	command = "if winnr('$') == 1 && bufname() =~ glob2regpat('term:*/bin/bash') | quit | endif",
	nested = true,
})

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
local function tab_win_closed(winnr)
	local api = require "nvim-tree.api"
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
		-- Close all nvim tree on :q
		if not vim.tbl_isempty(tab_bufs) then     -- and was not the last window (not closed automatically by code below)
			api.tree.close()
		end
	else                                                -- else closed buffer was normal buffer
		if #tab_bufs == 1 then                           -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
				vim.schedule(function()
					if #vim.api.nvim_list_wins() == 1 then  -- if its the last buffer in vim
						vim.cmd "quit"                       -- then close all of vim
					else                                    -- else there are more tabs open
						vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
					end
				end)
			end
		end
	end
end

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		local winnr = tonumber(vim.fn.expand("<amatch>"))
		vim.schedule_wrap(tab_win_closed(winnr))
	end,
	nested = true
})
