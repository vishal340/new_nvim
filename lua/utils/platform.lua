local M = {}

function M.newest_gxx_driver()
	local drivers = vim.fn.glob("/opt/homebrew/bin/g++-*", true, true)
	if #drivers == 0 then
		drivers = vim.fn.glob("/usr/local/bin/g++-*", true, true)
	end
	table.sort(drivers)
	return drivers[#drivers]
end

return M
