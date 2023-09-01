vim.cmd([[
	setlocal spell
	setlocal linebreaksetlocal conceallevel=2
	setlocal foldexpr=
	nnoremap <silent><localleader>m :let @+=trim(execute('1messages'))[14:] <bar> silent exec "!open '".@+"'"<cr>
]])
