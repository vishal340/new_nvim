return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			sync_install = false,
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
			indent = { enable = true },
			textobjects = {
				move = {
					enable = true,
					set_jumps = false, -- you can change this if you want.
					goto_next_start = {
						--- ... other keymaps
						["]b"] = { query = "@code_cell.inner", desc = "next code block" },
					},
					goto_previous_start = {
						--- ... other keymaps
						["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
					},
				},
				select = {
					enable = true,
					lookahead = true, -- you can change this if you want
					keymaps = {
						--- ... other keymaps
						["ib"] = { query = "@code_cell.inner", desc = "in block" },
						["ab"] = { query = "@code_cell.outer", desc = "around block" },
					},
				},
				swap = { -- Swap only works with code blocks that are under the same
					-- markdown header
					enable = true,
					swap_next = {
						--- ... other keymap
						["<leader>sbl"] = "@code_cell.outer",
					},
					swap_previous = {
						--- ... other keymap
						["<leader>sbh"] = "@code_cell.outer",
					},
				},
			},
		})
	end,
}
