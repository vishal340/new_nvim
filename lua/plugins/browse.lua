return {
	"lalitmee/browse.nvim",
	dependecies = { "nvim-telescope/telescope.nvim" },
	event = "VeryLazy",
	opts = {
		provider = "duckduckgo",
		bookmarks = {
			"https://devdocs.io/%s",
			["github"] = {
				["code_search"] = "https://github.com/search?q=%s&type=code",
				["repo_search"] = "https://github.com/search?q=%s&type=repositories",
				["issues_search"] = "https://github.com/search?q=%s&type=issues",
				["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
			},
			["node"] ={
				["npm_doc"] = "https://docs.npmjs.com/searcch?q=%s",
			},
			["cpp"] ={
				["cppreference"] = "https://en.cppreference.com/mwiki/index.php?search=%s",
				["cplusplus"] = "https://cplusplus.com/search.do?q=%s",
			},
			["go"] ={
				["go.dev"] = "https://pkg.go.dev/search?q=%s",
			},
			["rust"] ={
				["library"] = "https://doc.rust-lang.org/std/index.html?search=%s",
				["Error_code"] = "https://doc.rust-lang.org/error_codes/%s.html"
			}
		},
	}
}
