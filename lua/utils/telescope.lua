local builtin = require("telescope.builtin")
local git = require("utils.git")

local M = {}

local function with_git_root(opts)
	opts = opts or {}
	if git.is_repo() then
		opts.cwd = opts.cwd or git.root()
	end
	return opts
end

function M.find_files(opts)
	builtin.find_files(with_git_root(opts))
end

function M.live_grep(opts)
	builtin.live_grep(with_git_root(opts))
end

return M
