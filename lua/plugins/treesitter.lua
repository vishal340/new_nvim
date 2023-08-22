return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
	build = ':TSUpdate',
	lazy = true,
	config = function()
		require('nvim-treesitter.configs').setup {
		  highlight = {
			 enable = true,
			 additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
		  },
		  ensure_installed = {'org', 'rust', 'toml', 'html', 'vim', 'c', 'cpp', 'go', 'lua', 'bash', 'http', 'json','llvm', 'java', 'cuda', 'yaml', 'cmake', 'latex', 'make' ,'regex', 'python', 'markdown', 'vimdoc', 'comment', 'typescript', 'javascript'},
	  }
	end,
}
