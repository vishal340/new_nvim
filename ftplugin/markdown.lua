vim.cmd([[
	nnoremap <silent><localleader>m :let @+=trim(execute('1messages'))[14:] <bar> silent exec "!open '".@+"'"<cr>
]])
