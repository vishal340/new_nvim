vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.cindent = false

vim.cmd([[
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

vim.keymap.set("i", "std", "std::", { buffer = true })
vim.opt.keywordprg = "cppreference-doc"
