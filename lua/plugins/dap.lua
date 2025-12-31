local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		require("dapui").setup({})

		require("dap-python").setup()
		require("dap-python").setup("~/.virtualenvs/debugpy/bin/python3")
		require("dap-python").test_runner = "pytest"

		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- adjust as needed
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end
		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		dap.adapters.bashdb = {
			type = "executable",
			command = "bash-debug-adapter",
			name = "bashdb",
		}

		dap.configurations.sh = {
			{
				type = "bashdb",
				request = "launch",
				name = "Launch file",
				showDebugOutput = true,
				pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
				pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
				trace = true,
				file = "${file}",
				program = "${file}",
				cwd = "${workspaceFolder}",
				pathCat = "cat",
				pathBash = "/bin/bash",
				pathMkfifo = "mkfifo",
				pathPkill = "pkill",
				args = {},
				env = {},
				terminalKind = "integrated",
			},
		}

		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug test", -- configuration for debugging test files
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			-- works with go.mod packages and sub packages
			{
				type = "delve",
				name = "Debug test (go.mod)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		}

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
				runtimeExecutable = "node",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.java = {
			{
				javaExec = "java",
				request = "launch",
				type = "java",
			},
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
		keymap("n", "<localleader>dn", ":DapNew<cr>", opts)
		keymap("n", "<localleader>dc", ":lua  require('dap').continue()<cr>", opts)
		keymap("n", "<localleader>drs", ":lua  require('dap').continue()<cr>", opts)
		keymap("n", "<localleader>dsv", ":lua  require('dap').step_over()<cr>", opts)
		keymap("n", "<localleader>dsi", ":lua  require('dap').step_into()<cr>", opts)
		keymap("n", "<localleader>dso", ":lua  require('dap').step_out()<cr>", opts)
		keymap("n", "<localleader>db", ":lua  require('dap').toggle_breakpoint()<cr>", opts)
		keymap("n", "<localleader>dro", ":lua  require('dap').repl.open()<cr>", opts)
		keymap("n", "<localleader>dl", ":lua  require('dap').run_last()<cr>", opts)
		keymap({ "n", "v" }, "<localleader>dh", function()
			require("dap.ui.widgets").hover()
		end, opts)
		keymap({ "n", "v" }, "<localleader>dp", function()
			require("dap.ui.widgets").preview()
		end, opts)
		keymap("n", "<localleader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, opts)
		keymap("n", "<localleader>dfs", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, opts)

		keymap("n", "<localleader>dt", ':lua require("dapui").toggle()<cr>', opts)
		keymap("v", "<localleader>de", ':lua require("dapui").eval()<cr>', opts)
	end,
}
