vim.cmd([[
setlocal tabstop=2
setlocal shiftwidth=2
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
