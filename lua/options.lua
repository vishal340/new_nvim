vim.cmd([[
set encoding=utf-8
set mouse=a
set tabstop=3
set shiftwidth=3
set noexpandtab
set hidden
set ignorecase
set number
set relativenumber
set numberwidth=3
set wildmenu
set scrolloff=1
set history=1000
set belloff=all
set clipboard+=unnamedplus
set timeout
set timeoutlen=1000
set ttimeoutlen=200
set updatetime=70
set nobackup
set nowritebackup
set splitright
set splitbelow
set termguicolors
set noswapfile
set path+=**
set modifiable
set autochdir
set completeopt=menu,menuone,noselect
" set guicursor=n-v-c:block,i-ci-ve:ver10,r-cr:hor100,o:hor100
set viewoptions=cursor,folds,slash,unix
set viewoptions-=options
]])
vim.diagnostic.config({
	virtual_text = false
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.startify_session_autoload = 0
vim.g.startify_session_delete_buffers = 0
vim.g.startify_session_number = 20
vim.g.startify_session_persistence = 0
vim.g.startify_files_number = 30

--the convention used to save session is session name then underscore
--separated by branch name(if not main branch).
--before opening the branch first jump to that branch then open it

vim.cmd([[
	"let g:startify_lists = [
			\{ 'type': 'files',     'header': ['   MRU']},
			\{ 'type': 'sessions',  'header': ['   Sessions']},
			\]
			]])
vim.g.markdown_fenced_languages = { "cpp", "c", "rust", "go", "lua", "bash", "javascript", "typescript", "python" }

vim.g.gist_token = "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"
vim.g.gist_clip_command = 'xclip -selection clipboard'
vim.g.gist_show_privates = 1

-- vim.g.mkdp_browser = '/usr/bin/firefox'
vim.g.mkdp_auto_start = 1
vim.g.mkdp_auto_close = 1
vim.g.mkdp_command_for_global = 1
vim.g.mkdp_echo_preview_url = 1
