local continue = require("custom.utils.continue")

local M = {}

local function table_merge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				table_merge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

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
	n = table_merge({
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
	v = table_merge({}, dap_n_and_v),
}

M.lspconfig = {
	n = {
		["gh"] = {
			"<cmd>Lspsaga lsp_finder<CR>",
			"LSP finder",
		},
	},
}

return M
