local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
vim.cmd('verbose imap <tab>')

--TODO: the line below doesn't work as intended
keymap('n', 'gft', ':tabnew <bar> :edit <cfile><cr>')
keymap('n', 'gfv', ':vs <bar> :edit <cfile><cr>')
keymap('n', 'gfh', ':sp <bar> :edit <cfile><cr>')
keymap('n', '<leader>cl', ':nohlsearch<cr>')
keymap('n', '<F4>', ':w<cr>')
keymap('i', '<F4>', '<C-o>:w<cr>')
keymap('n', 'Y', 'y$')
keymap('n', '<leader><right>', ':vertical resize +5<cr>')
keymap('n', '<leader><left>', ':vertical resize -5<cr>')
keymap('n', '<leader><up>', ':resize +2<cr>')
keymap('n', '<leader><down>', ':resize -2<cr>')
keymap('n', '<leader>t', ":let $VIM_DIR=expand('%:p:h')<cr> :40vs <bar> terminal<cr>i cd $VIM_DIR<cr>")
keymap('n', '<leader>T', ":let $VIM_DIR=expand('%:p:h')<cr> :10sp <bar> terminal<cr>i cd $VIM_DIR<cr>")
keymap('n', '<leader><tab>', ':tabnew<space>')
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')
keymap('i', '<C-h>', '<C-o><C-w>h')
keymap('i', '<C-j>', '<C-o><C-w>j')
keymap('i', '<C-k>', '<C-o><C-w>k')
keymap('i', '<C-l>', '<C-o><C-w>l')
--In insert mode, pressing ctrl + numpad's+ increases the font
keymap('i', '<C-kPlus>', '<Esc>call AdjustFontSize(1)<CR>a')
keymap('i', '<C-kMinus>', '<Esc>:call AdjustFontSize(-1)<CR>a')
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h')
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j')
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k')
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l')
keymap('t', '<ESC>', '<C-\\><C-n>')
keymap('v', '<leader>y', ":'<,'>w !xclip -selection clipboard<Cr><Cr>")
keymap('n', '<leader>v', '<C-v>')
keymap('i', '<C-u>', '<C-o><C-u>')
keymap('i', '<C-d>', '<C-o><C-d>')
keymap('i', '<C-b>', '<C-o><C-b>')
keymap('i', '<C-f>', '<C-o><C-f>')
keymap('n', '<leader>*', 'g* :let $str=getreg("/")<cr> :Ggrep -q $str')
keymap('n', "<leader>bt", ":highlight Normal guibg=NONE<cr>")
keymap('n', "<leader>bb", ":highlight Normal guibg=BLACK<cr>")
keymap('c', "<M-h>", "vert h ")
keymap('i', '<M-w>', '<C-o>w', opts)
keymap('i', '<M-W>', '<C-o>W', opts)
keymap('i', '<M-b>', '<C-o>b', opts)
keymap('i', '<M-B>', '<C-o>B', opts)
keymap('i', '<M-e>', '<C-o>e', opts)
keymap('i', '<M-E>', '<C-o>E', opts)
keymap('i', '<M-i>', '<C-o>^', opts)
keymap('i', '<M-a>', '<C-o>$', opts)
keymap('i', '<M-.>', '<C-o>.', opts)
keymap('i', '<M-u>', '<C-o>u', opts)
keymap('i', '<M-5>', '<C-o>%', opts)
keymap('i', '<M-d>', '<C-o>d', opts)
keymap('i', '<M-y>', '<C-o>y', opts)
keymap('i', '<M-s>', '<C-o>s', opts)

keymap("n", "<leader>s", ":vs <bar> :Startify<cr>")
keymap("n", "<leader>S", ":sp <bar> :Startify<cr>")

local ls = require("luasnip")
vim.keymap.set({ "i" }, "<M-h>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<M-j>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<M-k>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<M-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

keymap("n", "<leader>r", ":SnipRun<cr>", opts)
keymap("v", "<leader>r", ":'<,'>SnipRun<cr>", opts)

keymap("v", "<localleader>hc", ":<c-u>HSHighlight<CR>", opts)
keymap("v", "<localleader>hr", ":<c-u>HSRmHighlight<CR>", opts)

keymap("n", "<leader>b", "<cmd>lua require('browse').input_search()<cr>", opts)
keymap("n", "<localleader>b", "<cmd>lua require('browse').browse(bookmarks)<cr>", opts)
keymap("n", "<localleader>bd", "<cmd>lua require('browse.devdocs').search_with_filetype()<cr>", opts)

keymap('n', '<localleader>dc', function() require('dap').continue() end, opts)
keymap('n', '<localleader>dsv', function() require('dap').step_over() end, opts)
keymap('n', '<localleader>dsi', function() require('dap').step_into() end, opts)
keymap('n', '<localleader>dso', function() require('dap').step_out() end, opts)
keymap('n', '<localleader>db', function() require('dap').toggle_breakpoint() end, opts)
keymap('n', '<localleader>dr', function() require('dap').repl.open() end, opts)
keymap('n', '<localleader>dl', function() require('dap').run_last() end, opts)
keymap({ 'n', 'v' }, '<localleader>dh', function()
	require('dap.ui.widgets').hover()
end, opts)
keymap({ 'n', 'v' }, '<localleader>dp', function()
	require('dap.ui.widgets').preview()
end, opts)
keymap('n', '<localleader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end, opts)
keymap('n', '<localleader>dfs', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end, opts)

keymap('n', '<localleader>dt', ':lua require("dapui").toggle()<cr>', opts)
keymap('v', '<localleader>de', ':lua require("dapui").eval()<cr>', opts)

keymap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', opts)
keymap('n', '<leader>ef', '<cmd>NvimTreeFocus<cr>', opts)

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
	require("telescope.builtin").find_files(opt)
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

	require("telescope.builtin").live_grep(opt)
end

keymap('n', '<leader>ff', function()
	find_files_from_project_git_root()
end)
keymap('n', '<leader>fg', function()
	live_grep_from_project_git_root()
end)
keymap('n', '<leader>fm', ':Telescope marks preview=true<cr>')
keymap('n', '<leader>fb', ':Telescope buffers<cr>')
keymap('n', '<leader>fh', ':Telescope help_tags preview=true<cr>')
keymap('n', '<leader>fo', ':Telescope oldfiles preview=false<cr>')
keymap('n', '<localleader>gc', function()
	require('telescope.builtin').git_bcommits()
end)
keymap('v', '<localleader>gc', function()
	require('telescope.builtin').git_bcommits_range()
end)
keymap('n', '<localleader>gb', function()
	require('telescope.builtin').git_branches()
end)
keymap('n', '<localleader>gs', function()
	require('telescope.builtin').git_status()
end)
local api = require('remote-sshfs.api')
vim.keymap.set('n', '<localleader>rc', api.connect, {})
vim.keymap.set('n', '<localleader>rd', api.disconnect, {})
vim.keymap.set('n', '<localleader>re', api.edit, {})

-- (optional) Override telescope find_files and live_grep to make dynamic based on if connected to host
local builtin = require("telescope.builtin")
local connections = require("remote-sshfs.connections")
vim.keymap.set("n", "<localleader>rff", function()
	if connections.is_connected then
		api.find_files()
	else
		builtin.find_files()
	end
end, {})
vim.keymap.set("n", "<localleader>rfg", function()
	if connections.is_connected then
		api.live_grep()
	else
		builtin.live_grep()
	end
end, {})
