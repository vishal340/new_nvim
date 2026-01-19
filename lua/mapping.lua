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

keymap("n", "ze", ":buffers<cr>:buffer ")
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

keymap("n", "gT", function()
	if vim.v.count == 0 then
		vim.cmd("normal! gT")
	else
		for i = 1, vim.v.count do
			vim.cmd("normal! gT")
		end
	end
end)
keymap("n", "gt", function()
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

local builtin = require("telescope.builtin")

local find_files_from_project_git_root = function()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")
		return vim.v.shell_error == 0
	end
	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end
	local opt = {}
	if is_git_repo() then
		opt = {
			cwd = get_git_root(),
		}
	end
	builtin.find_files(opt)
end

local live_grep_from_project_git_root = function()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opt = {}

	if is_git_repo() then
		opt = {
			cwd = get_git_root(),
		}
	end

	builtin.live_grep(opt)
end

keymap("n", "<leader>ff", function()
	find_files_from_project_git_root()
end)
keymap("n", "<leader>fg", function()
	live_grep_from_project_git_root()
end)
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

vim.cmd([[
function! GetUniqueSessionName()
	let l:branch = gitbranch#name()
	let l:branch = empty(l:branch) ? '' : '-' . l:branch
	let l:container={}
	function container.is_git_repo()
		let _= system("git rev-parse --is-inside-work-tree")
		return v:shell_error==0
	endfunction
	if container.is_git_repo()
		return substitute(fnamemodify(finddir(".git",".;"),":~:h") . l:branch, '/', '-', 'g')
	endif
	return substitute(fnamemodify(getcwd(),":~:h") . l:branch, '/', '-', 'g')
endfunction
]])

keymap("n", "<localleader>ss", ":execute 'SSave!'  . GetUniqueSessionName()<cr>")
keymap("n", "<localleader>st", ":Startify<cr>")

-- below are mappings specific for lsp
local bufopts = { noremap = true, silent = true, buffer = bufnr }
keymap("n", "<leader>gfd", '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', bufopts)
keymap("n", "<leader>gfi", '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', bufopts)
keymap("n", "<leader>gfr", '<cmd>lua require("goto-preview").goto_preview_references()<CR>', bufopts)
keymap("n", "<leader>gti", "<cmd>tab split| lua vim.lsp.buf.implementation()<cr>", bufopts)
keymap("n", "<leader>gvi", "<cmd>vs| lua vim.lsp.buf.implementation()<cr>", bufopts)
keymap("n", "<leader>ghi", "<cmd>sp| lua vim.lsp.buf.implementation()<cr>", bufopts)
keymap("n", "<leader>gi", function()
	builtin.lsp_implementations()
end, bufopts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", bufopts)
keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", bufopts)
keymap("n", "<leader>ll", function()
	builtin.treesitter()
end, bufopts)
keymap("n", "<leader>lic", function()
	builtin.lsp_incoming_calls()
end, bufopts)
keymap("n", "<leader>loc", function()
	builtin.lsp_outgoing_calls()
end, bufopts)
keymap("n", "<leader>bf", "<cmd>lua vim.lsp.buf.formatting()<cr>", bufopts)

keymap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<cr>", bufopts)
keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufopts)
keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufopts)
keymap("n", "<leader>dh", "<cmd>lua vim.diagnostic.hide()<cr>", bufopts)
keymap("n", "<leader>ds", "<cmd>lua vim.diagnostic.show()<cr>", bufopts)
keymap("n", "<leader>gft", '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', bufopts)
keymap("n", "<leader>ih", function()
	if vim.lsp.inlay_hint.is_enabled(0) then
		vim.lsp.inlay_hint.enable(0, false)
	else
		vim.lsp.inlay_hint.enable(0, true)
	end
end)

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
end, bufopts)
