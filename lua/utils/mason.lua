local M = {}

local data = vim.fn.stdpath("data")

function M.packages(...)
	local parts = { data, "mason", "packages", ... }
	return table.concat(parts, "/")
end

function M.bin(name)
	return data .. "/mason/bin/" .. name
end

function M.glob_jars(pattern)
	return vim.fn.glob(M.packages(pattern), true, true)
end

return M
