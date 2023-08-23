-- This is installed using make but it didn't work directly and i had to manually make it in the directory
-- I suggest install it using cmake
return {
	'nvim-telescope/telescope-fzf-native.nvim',
	event = "VeryLazy",
	build = 'make',
}
