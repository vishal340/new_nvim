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
		  ensure_installed = {'org', 'rust', 'toml', 'html', 'vim', 'c', 'cpp', 'go', 'lua', 'bash', 'http', 'json','llvm', 'java', 'cuda', 'yaml', 'cmake', 'latex', 'make' ,'regex', 'python', 'markdown', 'vimdoc', 'comment', 'typescript', 'javascript'}, -- Or run :TSUpdate org
	  }
	end,
	config = function()
		vim.cmd([[
		function DisableSyntaxTreesitter()
			 if exists(':TSBufDisable')
				  exec 'TSBufDisable autotag'
				  exec 'TSBufDisable highlight'
				  exec 'TSBufDisable incremental_selection'
				  exec 'TSBufDisable indent'
				  exec 'TSBufDisable playground'
				  exec 'TSBufDisable rainbow'
				  exec 'TSBufDisable refactor.highlight_definitions'
				  exec 'TSBufDisable refactor.navigation'
				  exec 'TSBufDisable refactor.smart_rename'
				  exec 'TSBufDisable refactor.highlight_current_scope'
				  exec 'TSBufDisable textobjects.swap'
				  " exec 'TSBufDisable textobjects.move'
				  exec 'TSBufDisable textobjects.lsp_interop'
				  exec 'TSBufDisable textobjects.select'
			 endif

			 set foldmethod=manual
		endfunction

		augroup BigFileDisable
			 autocmd!
			 autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
		augroup END
		]])
	end
}

