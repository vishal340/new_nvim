return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local function num() return vim.fn.tabpagenr() end
		require('lualine').setup {
			sections = {
				lualine_c = { 'filename' },
				lualine_x = { num, 'fileformat', 'filetype' },
			},
			inactive_sections = {
				lualine_b = { 'branch', 'diff', 'diagnostics' },
			},
		}
	end
}
