local continue = require("custom.utils.continue")

local M = {}

local dap_n_and_v = {
	["<leader>dh"] = {
		function()
			require("dap.ui.widgets").hover()
		end,
		"Debugger hover",
	},
	["<leader>dp"] = {
		function()
			require("dap.ui.widgets").preview()
		end,
		"Debugger preview",
	},
}

M.dap = {
	n = vim.tbl_deep_extend("error", {
		["<F5>"] = {
			continue,
			"Launch debugger",
		},
		["<F10>"] = {
			function()
				require("dap").step_over()
			end,
			"Debugger step over",
		},
		["<F11>"] = {
			function()
				require("dap").step_into()
			end,
			"Debugger step into",
		},
		["<F12>"] = {
			function()
				require("dap").step_out()
			end,
			"Debugger step out",
		},
		["<Leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		["<Leader>dB"] = {
			function()
				require("dap").set_breakpoint()
			end,
			"Set breakpoint",
		},
		["<Leader>lp"] = {
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			"Set log point",
		},
		["<Leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"Debugger open repl",
		},
		["<Leader>dl"] = {
			function()
				require("dap").run_last()
			end,
			"Debugger run last",
		},
		["<Leader>df"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"Debugger show frames",
		},
		["<Leader>ds"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"Debugger show scopes",
		},
	}, dap_n_and_v),
	v = vim.tbl_deep_extend("error", {}, dap_n_and_v),
}

M.lspconfig = {
	n = {
		["gh"] = {
			function()
				vim.cmd("Lspsaga finder")
			end,
			"LSP finder",
		},
		["<leader>o"] = {
			function()
				vim.cmd("Lspsaga outline")
			end,
			"LSP outline",
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
		["<leader>fb"] = {
			function()
				require("telescope").extensions.file_browser.file_browser()
			end,
			"File Browser",
		},
		["<leader>fr"] = {
			function()
				require("telescope.builtin").resume()
			end,
			"Finder resume",
		},
		["<leader>fd"] = {
			function()
				require("telescope.builtin").diagnostics()
			end,
			"Find diagnostics",
		},
		["<leader>fc"] = {
			function()
				require("telescope").extensions.neoclip.default()
			end,
			"Find in clipboard",
		},
		["<leader>fw"] = {
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			"Live grep",
		},
	},
}

return M
