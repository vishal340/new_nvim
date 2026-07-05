return {
	"mfussenegger/nvim-dap",
	lazy = true,
	cmd = {
		"DapContinue",
		"DapToggleBreakpoint",
		"DapNew",
		"DapTerminate",
		"DapRestart",
		"DapRunLast",
	},
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason = require("utils.mason")

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
			floating = { border = "rounded" },
		})

		local function setup_dap_python()
			local candidates = {
				vim.fn.expand("~/.virtualenvs/debugpy/bin/python3"),
				mason.packages("debugpy", "venv/bin/python"),
				mason.packages("debugpy", "venv/bin/python3"),
			}
			for _, python in ipairs(candidates) do
				if vim.fn.executable(python) == 1 then
					require("dap-python").setup(python)
					require("dap-python").test_runner = "pytest"
					return
				end
			end
			vim.notify("debugpy not found; install with :MasonInstall debugpy", vim.log.levels.WARN)
		end
		setup_dap_python()

		local codelldb = mason.packages("codelldb", "extension/adapter/codelldb")
		if vim.fn.executable(codelldb) == 1 then
			dap.adapters.codelldb = {
				type = "executable",
				command = codelldb,
				args = { "--port", "${port}" },
			}
		else
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb",
			}
		end

		local cpp_launch = {
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
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = function()
					return tonumber(vim.fn.input("Process ID: "))
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.cpp = cpp_launch
		dap.configurations.c = cpp_launch
		dap.configurations.rust = cpp_launch

		dap.adapters.nlua = function(_, config)
			return { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
		end
		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
				host = "127.0.0.1",
				port = 8086,
			},
		}

		local bashdb = mason.packages("bash-debug-adapter", "extension/bashdb_dir/bashdb")
		local bashdb_lib = mason.packages("bash-debug-adapter", "extension/bashdb_dir")
		dap.adapters.bashdb = {
			type = "executable",
			command = mason.packages("bash-debug-adapter", "extension/debugAdapter.sh"),
			name = "bashdb",
		}
		dap.configurations.sh = {
			{
				type = "bashdb",
				request = "launch",
				name = "Launch file",
				showDebugOutput = true,
				pathBashdb = bashdb,
				pathBashdbLib = bashdb_lib,
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
				name = "Debug test",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug test (go.mod)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		}

		local js_adapter = mason.packages("js-debug-adapter", "js-debug-adapter")
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = vim.fn.executable(js_adapter) == 1 and js_adapter or "js-debug-adapter",
				args = { "${port}" },
			},
		}
		local js_launch = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
				runtimeExecutable = "node",
			},
		}
		dap.configurations.javascript = js_launch
		dap.configurations.typescript = js_launch
		dap.configurations.java = {
			{
				javaExec = "java",
				request = "launch",
				type = "java",
				name = "Launch Java",
			},
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}

		dap.listeners.after.event_initialized["dapui"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui"] = function()
			dapui.close({})
		end

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
		end

		map("n", "<localleader>dn", ":DapNew<cr>", "Debug: select configuration")
		map("n", "<localleader>dc", dap.continue, "Debug: continue")
		map("n", "<localleader>dsv", dap.step_over, "Debug: step over")
		map("n", "<localleader>dsi", dap.step_into, "Debug: step into")
		map("n", "<localleader>dso", dap.step_out, "Debug: step out")
		map("n", "<localleader>db", dap.toggle_breakpoint, "Debug: toggle breakpoint")
		map("n", "<localleader>dB", function()
			dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Debug: conditional breakpoint")
		map("n", "<localleader>dx", dap.terminate, "Debug: terminate")
		map("n", "<localleader>dr", dap.restart, "Debug: restart")
		map("n", "<localleader>dro", dap.repl.open, "Debug: open REPL")
		map("n", "<localleader>dl", dap.run_last, "Debug: run last")
		map({ "n", "v" }, "<localleader>dh", function()
			require("dap.ui.widgets").hover()
		end, "Debug: hover")
		map({ "n", "v" }, "<localleader>dp", function()
			require("dap.ui.widgets").preview()
		end, "Debug: preview")
		map("n", "<localleader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, "Debug: frames")
		map("n", "<localleader>dfs", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, "Debug: scopes")
		map("n", "<localleader>dt", dapui.toggle, "Debug: toggle UI")
		map("v", "<localleader>de", dapui.eval, "Debug: evaluate")
		map("n", "<localleader>dzm", function()
			require("dap-python").test_method()
		end, "Debug: Python test method")
		map("n", "<localleader>dzc", function()
			require("dap-python").test_class()
		end, "Debug: Python test class")
		map("n", "<localleader>dzf", function()
			require("dap-python").test_module()
		end, "Debug: Python test file")
	end,
}
