local continue = require("custom.utils.continue")

local M = {}

M.disabled = {
	n = {
		["<Leader>b"] = "",
	},
	v = {
		["<Leader>b"] = "",
	},
}

local dap_n_and_v = {
	["<leader>dh"] = {
		function()
			require("dap.ui.widgets").hover()
		end,
		"Debugger Hover",
	},
	["<leader>dp"] = {
		function()
			require("dap.ui.widgets").preview()
		end,
		"Debugger Preview",
	},
}

M.dap = {
	n = vim.tbl_deep_extend("error", {
		["<F5>"] = {
			continue,
			"Launch Debugger",
		},
		["<F10>"] = {
			function()
				require("dap").step_over()
			end,
			"Debugger Step Over",
		},
		["<F11>"] = {
			function()
				require("dap").step_into()
			end,
			"Debugger Step Into",
		},
		["<F12>"] = {
			function()
				require("dap").step_out()
			end,
			"Debugger Step Out",
		},
		["<Leader>b"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle Breakpoint",
		},
		["<Leader>B"] = {
			function()
				require("dap").set_breakpoint()
			end,
			"Set Breakpoint",
		},
		["<Leader>lp"] = {
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			"Set Log Point",
		},
		["<Leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"Debugger Open Repl",
		},
		["<Leader>dl"] = {
			function()
				require("dap").run_last()
			end,
			"Debugger Run Last",
		},
		["<Leader>df"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"Debugger Show Frames",
		},
		["<Leader>ds"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"Debugger Show Scopes",
		},
	}, dap_n_and_v),
	v = vim.tbl_deep_extend("error", {}, dap_n_and_v),
}

M.lspconfig = {
	n = {
		["gh"] = {
			function()
				vim.cmd("Lspsaga lsp_finder")
			end,
			"LSP Finder",
		},
		["<leader>o"] = {
			function()
				vim.cmd("Lspsaga outline")
			end,
			"LSP Outline",
		},
	},
}

M.neotest = {
	n = {
		["<leader>tr"] = {
			function()
				require("neotest").run.run()
			end,
			"Run nearest test",
		},
		["<leader>tf"] = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"Run tests in file",
		},
		["<leader>td"] = {
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			"Debug nearest test",
		},
		["<leader>tx"] = {
			function()
				require("neotest").run.stop()
			end,
			"Stop nearest test",
		},
		["<leader>tw"] = {
			function()
				require("neotest").run.run({ jestCommand = "jest --watch " })
			end,
			"Test watch",
		},
		["<leader>to"] = {
			function()
				require("neotest").summary.toggle()
			end,
			"Tests outline",
		},
	},
}

M.telescope = {
	n = {
		["<leader>fr"] = {
			function()
				require("telescope.builtin").resume()
			end,
			"Finder resume",
		},
	},
}

return M
