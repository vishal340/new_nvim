return {
	"klen/nvim-config-local",
	opts = {
		config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
		hashfile = vim.fn.stdpath("data") .. "/config-local",
		autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
		commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
		silent = false,         -- Disable plugin messages (Config loaded/ignored)
		lookup_parents = true,  -- Lookup config files in parent directories
	}
}
