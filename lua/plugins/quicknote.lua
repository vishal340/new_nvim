return {
	"RutaTang/quicknote.nvim",
	config = function()
		require("quicknote").setup({
			mode = "resident",
		})
		vim.api.nvim_set_keymap("n", "<localleader>qn", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>", {})
		vim.api.nvim_set_keymap(
			"n",
			"<localleader>qo",
			"<cmd>:lua require('quicknote').OpenNoteAtCurrentLine()<cr>",
			{}
		)
		vim.api.nvim_set_keymap(
			"n",
			"<localleader>qd",
			"<cmd>:lua require('quicknote').DeleteNoteAtCurrentLine()<cr>",
			{}
		)
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}
