return {
	"kelly-lin/ranger.nvim",
	config = function()
		local ranger_nvim = require("ranger-nvim")
		ranger_nvim.setup({
			replace_netrw = true,
			keybinds = {
				["<C-v>"] = ranger_nvim.OPEN_MODE.vsplit,
				["<C-h>"] = ranger_nvim.OPEN_MODE.split,
				["<C-t>"] = ranger_nvim.OPEN_MODE.tabedit,
				["<C-r>"] = ranger_nvim.OPEN_MODE.rifle,
			},
		})
		vim.api.nvim_set_keymap("n", "<localleader>e", "", {
			noremap = true,
			callback = function()
				require("ranger-nvim").open(true)
			end,
			desc = "open ranger",
		})
	end,
}
