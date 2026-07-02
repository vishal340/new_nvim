return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"java",
				"python",
				"go",
				"rust",
				"javascript",
				"typescript",
				"json",
				"yaml",
				"bash",
				"html",
				"dockerfile",
				"cmake",
				"markdown",
				"markdown_inline",
				"sql",
				"regex",
				"comment",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
				disable = function(lang, buf)
					local max_filesize = 1024 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = {
				enable = true,
				disable = function(lang, buf)
					-- Treesitter c/cpp indent queries error on some Neovim builds;
					-- cindent in after/ftplugin/cpp.lua handles brace indent instead.
					if lang == "cpp" or lang == "c" then
						return true
					end
					local max_filesize = 1024 * 1024
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true, -- you can change this if you want.
					goto_next_start = {
						--- ... other keymaps
						["]b"] = { query = "@code_cell.inner", desc = "next code block" },
						["]f"] = { query = "@function.outer", desc = "next function" },
					},
					goto_previous_start = {
						--- ... other keymaps
						["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
						["[f"] = { query = "@function.outer", desc = "previous function" },
					},
				},
				select = {
					enable = true,
					lookahead = true, -- you can change this if you want
					keymaps = {
						--- ... other keymaps
						["ib"] = { query = "@code_cell.inner", desc = "in block" },
						["ab"] = { query = "@code_cell.outer", desc = "around block" },
						["if"] = { query = "@function.inner", desc = "in function" },
						["af"] = { query = "@function.outer", desc = "around function" },
					},
				},
			},
		})
	end,
}
