local M = {}

function M.is_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	return vim.v.shell_error == 0
end

function M.root()
	local dot_git = vim.fn.finddir(".git", ".;")
	if dot_git == "" then
		return vim.fn.getcwd()
	end
	return vim.fn.fnamemodify(dot_git, ":h")
end

function M.session_name()
	local branch = vim.fn["gitbranch#name"]()
	local suffix = branch ~= "" and ("-" .. branch) or ""

	if M.is_repo() then
		local git_dir = vim.fn.finddir(".git", ".;")
		return vim.fn.substitute(vim.fn.fnamemodify(git_dir, ":~:h") .. suffix, "/", "-", "g")
	end

	return vim.fn.substitute(vim.fn.fnamemodify(vim.fn.getcwd(), ":~:h") .. suffix, "/", "-", "g")
end

return M
