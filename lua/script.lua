local id3 = vim.api.nvim_create_augroup("newtab", { clear = true })
vim.api.nvim_create_autocmd("TabNewEntered", {
	command = "if bufname('%') == '' | silent! Startify | endif",
	group = id3,
})
--The below 2 autocmd close any terminal and nerdtree window if there are no windows in that tabpage

-- local capture = ""
-- local id2 = vim.api.nvim_create_augroup("cmdline", { clear = true })
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	callback = function()
-- 		capture = vim.fn.getcmdline()
-- 	end,
-- 	group = id2,
-- })
--
-- local function auto_close(cur, cmd)
-- 	for x = 1, vim.fn.winnr("$") do
-- 		if x ~= cur and string.match(vim.fn.bufname(vim.fn.winbufnr(x)), ".*%.[a-zA-Z]+$") then
-- 			return
-- 		end
-- 	end
-- 	if vim.fn.tabpagenr("$") > 1 and not string.find(cmd, "a") then
-- 		vim.cmd("tabclose")
-- 	else
-- 		vim.cmd("quitall")
-- 	end
-- end
--
-- local id1 = vim.api.nvim_create_augroup("termclose", { clear = true })
-- vim.api.nvim_create_autocmd("QuitPre", {
-- 	callback = function()
-- 		if string.match(vim.fn.bufname(vim.fn.winbufnr(0)), ".*%.[a-zA-Z]+$") and vim.fn.winnr("$") > 1 then
-- 			auto_close(vim.fn.winnr(), capture)
-- 		end
-- 	end,
-- 	group = id1,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.py",
	callback = function(e)
		if string.match(e.file, ".otter.") then
			return
		end
		if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
			vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
			vim.fn.MoltenUpdateOption("virt_text_output", false)
		else
			vim.g.molten_virt_lines_off_by_1 = false
			vim.g.molten_virt_text_output = false
		end
	end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.qmd", "*.md", "*.ipynb" },
	callback = function(e)
		if string.match(e.file, ".otter.") then
			return
		end
		if require("molten.status").initialized() == "Molten" then
			vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
			vim.fn.MoltenUpdateOption("virt_text_output", true)
		else
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_virt_text_output = true
		end
	end,
})

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
	local path = filename .. ".ipynb"
	local file = io.open(path, "w")
	if file then
		file:write(default_notebook)
		file:close()
		vim.cmd("edit " .. path)
	else
		print("Error: Could not open new notebook file for writing.")
	end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
	new_notebook(opts.args)
end, {
	nargs = 1,
	complete = "file",
})
