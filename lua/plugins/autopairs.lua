return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		check_ts = true,
		map_cr = true,
		map_bs = true,
		enable_check_bracket_line = true,
		disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
	},
}
