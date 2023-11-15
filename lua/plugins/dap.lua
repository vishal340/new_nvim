return {
	{
		'mfussenegger/nvim-dap',
		event = "VeryLazy",
		config = function()
			local dap = require('dap')
			dap.adapters.lldb = {
				type = 'executable',
				command = '/usr/bin/lldb-vscode-14', -- adjust as needed
				name = "lldb"
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			dap.configurations.lua = {
				{
					type = 'nlua',
					request = 'attach',
					name = "Attach to running Neovim instance",
				}
			}

			dap.adapters.nlua = function(callback, config)
				callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
			end

			dap.adapters.bashdb = {
				type = 'executable',
				command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
				name = 'bashdb',
			}

			dap.configurations.sh = {
				{
					type = 'bashdb',
					request = 'launch',
					name = "Launch file",
					showDebugOutput = true,
					pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
					pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
					trace = true,
					file = "${file}",
					program = "${file}",
					cwd = '${workspaceFolder}',
					pathCat = "cat",
					pathBash = "/bin/bash",
					pathMkfifo = "mkfifo",
					pathPkill = "pkill",
					args = {},
					env = {},
					terminalKind = "integrated",
				}
			}

			dap.adapters.python = function(cb, config)
				if config.request == 'attach' then
					---@diagnostic disable-next-line: undefined-field
					local port = (config.connect or config).port
					---@diagnostic disable-next-line: undefined-field
					local host = (config.connect or config).host or '127.0.0.1'
					cb({
						type = 'server',
						port = assert(port, '`connect.port` is required for a python `attach` configuration'),
						host = host,
						options = {
							source_filetype = 'python',
						},
					})
				else
					cb({
						type = 'executable',
						command = 'path/to/virtualenvs/debugpy/bin/python',
						args = { '-m', 'debugpy.adapter' },
						options = {
							source_filetype = 'python',
						},
					})
				end
			end

			dap.adapters.delve = {
				type = 'server',
				port = '${port}',
				executable = {
					command = 'dlv',
					args = { 'dap', '-l', '127.0.0.1:${port}' },
				}
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}"
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}"
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}"
				}
			}

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.java = {
				{
					type = 'java',
					request = 'attach',
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}
		end
	},
	{
		"rcarriga/nvim-dap-ui",
		event = 'VeryLazy',
		dependecies = { "mfussenegger/nvim-dap" },
		opts = {}
	}
}
