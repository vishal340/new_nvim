return {
	"RutaTang/quicknote.nvim",
	config = function()
		require("quicknote").setup({
			mode = "resident", -- "portable" | "resident", default to "portable"
			sign = "N", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
			-- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
			filetype = "md",
			git_branch_recognizable = false, -- If true, quicknote will separate notes by git branch
			-- But it should only be used with resident mode,  it has not effect used with portable mode
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<localleader>qn",
			mode = { "n" },
			"<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>",
			desc = "create a new note at current line",
		},
		{
			"<localleader>ql",
			mode = { "n" },
			"<cmd>:lua require('quicknote').OpenNoteAtCurrentLine()<cr>",
			desc = "Open note at current line",
		},
		{
			"<localleader>qd",
			mode = { "n" },
			"<cmd>:lua require('quicknote').DeleteNoteAtCurrentLine()<cr>",
			desc = "create a new note at current line",
		},
	},
}
