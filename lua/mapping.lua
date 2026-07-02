local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- vim.cmd("verbose imap <tab>")

keymap("n", "gfv", ":vs <bar> :edit <cfile><cr>")
keymap("n", "gfh", ":sp <bar> :edit <cfile><cr>")
keymap("n", "<leader>cl", ":nohlsearch<cr>")
keymap("n", "<leader><right>", ":vertical resize +5<cr>")
keymap("n", "<leader><left>", ":vertical resize -5<cr>")
keymap("n", "<leader><up>", ":resize +2<cr>")
keymap("n", "<leader><down>", ":resize -2<cr>")
keymap("n", "<leader><tab>", ":tabnew<space>")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("i", "<C-h>", "<C-o><C-w>h")
keymap("i", "<C-j>", "<C-o><C-w>j")
keymap("i", "<C-k>", "<C-o><C-w>k")
keymap("i", "<C-l>", "<C-o><C-w>l")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")
keymap("t", "<ESC>", "<C-\\><C-n>")
keymap("v", "<leader>y", ":'<,'>w !xclip -selection clipboard<Cr><Cr>")
keymap("n", "<leader>v", "<C-v>")
keymap("i", "<C-u>", "<C-o><C-u>")
keymap("i", "<C-d>", "<C-o><C-d>")
keymap("i", "<C-b>", "<C-o><C-b>")
keymap("i", "<C-f>", "<C-o><C-f>")
keymap("n", "<leader>bt", ":highlight Normal guibg=NONE<cr>")
keymap("n", "<leader>bb", ":highlight Normal guibg=BLACK<cr>")
keymap("i", "<M-j>", "<C-o>j", opts)
keymap("i", "<M-k>", "<C-o>k", opts)
keymap("i", "<M-w>", "<C-o>w", opts)
keymap("i", "<M-W>", "<C-o>W", opts)
keymap("i", "<M-b>", "<C-o>b", opts)
keymap("i", "<M-B>", "<C-o>B", opts)
keymap("i", "<M-e>", "<C-o>e", opts)
keymap("i", "<M-E>", "<C-o>E", opts)
keymap("i", "<M-i>", "<C-o>^", opts)
keymap("i", "<M-A>", "<C-o>$", opts)
keymap("i", "<M-.>", "<C-o>.", opts)
keymap("i", "<M-u>", "<C-o>u", opts)
keymap("i", "<M-5>", "<C-o>%", opts)
keymap("i", "<M-d>", "<C-o>d", opts)
keymap("i", "<M-y>", "<C-o>y", opts)
keymap("i", "<M-s>", "<C-o>s", opts)

keymap("n", "ze", ":Telescope buffers<cr> ")
keymap("n", "zv", ":buffers<cr>:vs | buffer ")
keymap("n", "zh", ":buffers<cr>:sp | buffer ")
keymap("n", "zn", ":bn<cr>", opts)
keymap("n", "zp", ":bp<cr>", opts)
keymap("n", "zd", ":buffers<cr>:bdelete ")

keymap("n", "<F1>", ":q!<cr>")
keymap("n", "<F2>", ":messages<cr>")
keymap("n", "<F3>", ":file<cr>")
keymap("n", "<F4>", ":w<cr>")
keymap("i", "<F4>", "<C-o>:w<cr>")
keymap("n", "<F5>", ":Telescope ")
keymap("n", "<F6>", ":registers<cr>")
keymap("n", "<F7>", ":marks<cr>")

keymap("n", "<leader>gT", function()
	if vim.v.count == 0 then
		vim.cmd("normal! gT")
	else
		for i = 1, vim.v.count do
			vim.cmd("normal! gT")
		end
	end
end)
keymap("n", "<leader>gt", function()
	if vim.v.count == 0 then
		vim.cmd("normal! gt")
	else
		for i = 1, vim.v.count do
			vim.cmd("normal! gt")
		end
	end
end)

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		local new_target_window
		vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
			vim.cmd(direction .. " split")
			new_target_window = vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target_window)
		MiniFiles.go_in()
	end

	local desc = "Split " .. direction
	vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		map_split(buf_id, "gh", "belowright horizontal")
		map_split(buf_id, "gv", "belowright vertical")
	end,
})
keymap("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", opts)

local telescope = require("utils.telescope")

keymap("n", "<leader>ff", telescope.find_files)
keymap("n", "<leader>fg", telescope.live_grep)
keymap("n", "<leader>fm", ":Telescope marks preview=true<cr>")
keymap("n", "<leader>fb", ":Telescope buffers<cr>")
keymap("n", "<leader>fh", ":Telescope help_tags preview=true<cr>")
keymap("n", "<leader>fq", ":Telescope quickfix preview=true<cr>")
keymap("n", "<leader>fo", ":Telescope oldfiles preview=false<cr>")
keymap("n", "<leader>fn", ":Telescope quicknote preview=true<cr>")

keymap("n", "<localleader>mp", ":MarkdownPreview<cr>")

vim.cmd([[
autocmd TermEnter term://*toggleterm#*
     \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <silent><C-t> :ToggleTerm<CR>
]])

keymap("n", "<leader>*", ":Ggrep! -Iq <cword> <bar> cclose <bar> Telescope quickfix<cr>")
keymap("v", "<leader>*", 'y<c-u>:Ggrep! -Iq <c-r>" <bar> cclose <bar> Telescope quickfix<cr>')

keymap("n", "<localleader>ss", function()
	vim.cmd("SSave! " .. require("utils.git").session_name())
end, opts)
keymap("n", "<localleader>st", ":Startify<cr>")

-- goto-preview (global; LSP buffer maps live in lsp.on_attach)
keymap("n", "<leader>gfd", function()
	require("goto-preview").goto_preview_definition()
end, opts)
keymap("n", "<leader>gfi", function()
	require("goto-preview").goto_preview_implementation()
end, opts)
keymap("n", "<leader>gfr", function()
	require("goto-preview").goto_preview_references()
end, opts)
keymap("n", "<leader>gft", function()
	require("goto-preview").goto_preview_type_definition()
end, opts)

local tree_api = require("nvim-tree.api")

local git_add = function()
	local node = tree_api.tree.get_node_under_cursor()
	local gs = node.git_status.file

	-- If the current node is a directory get children status
	if gs == nil then
		gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
			or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
	end

	-- If the file is untracked, unstaged or partially staged, we stage it
	if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
		vim.cmd("silent !git add " .. node.absolute_path)

	-- If the file is staged, we unstage
	elseif gs == "M " or gs == "A " then
		vim.cmd("silent !git restore --staged " .. node.absolute_path)
	end

	tree_api.tree.reload()
end

vim.keymap.set("n", "ga", git_add, opts)

local swap_then_open_tab = function()
	local node = tree_api.tree.get_node_under_cursor()
	vim.cmd("wincmd l")
	tree_api.node.open.tab(node)
end

keymap("n", "<leader>t", function()
	swap_then_open_tab()
end, opts)
