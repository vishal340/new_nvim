local M = {}

local function plain_cr()
	return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
end

-- Snippet mode ends via unlink in lua/plugins/luasnip.lua (comp $0) and snippets/cpp.lua (codeforce).
function M.handle(cmp)
	if cmp and cmp.is_visible() then
		return false
	end

	local autopairs = require("nvim-autopairs")
	local ap_result = autopairs.autopairs_cr()
	if ap_result == plain_cr() then
		return false
	end
	return ap_result
end

return M
