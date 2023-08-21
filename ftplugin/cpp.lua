vim.cmd([[
" autocmd BufWinLeave *.cpp,*.hpp,*.h if &modifiable == 1 && &readonly == 0 | silent! exe "normal gg=GZZ" | endif

function! SetMkfile()
	let filemk = "Makefile"
	let pathmk = "./"
	let depth = 1
	while depth < 5
		if filereadable(pathmk . filemk)
			return pathmk
		endif
		let depth += 1
		let pathmk = "../" . pathmk
	endwhile
	return "."
endfunction

command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | c
]])
vim.keymap.set('i', 'std', 'std::', { buffer = true })
