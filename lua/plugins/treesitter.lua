return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	build = ':TSUpdate',
	event = "VeryLazy",
	opts = {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { 'org' }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
			disable = function(lang, buf)
				local max_filesize = 1024 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		ensure_installed = { 'org', 'rust', 'toml', 'html', 'vim', 'c', 'cpp', 'go', 'lua', 'bash', 'http', 'json', 'llvm',
			'java', 'cuda', 'yaml', 'cmake', 'latex', 'make', 'regex', 'python', 'markdown', 'vimdoc', 'comment',
			'typescript', 'javascript' },
	}
}
