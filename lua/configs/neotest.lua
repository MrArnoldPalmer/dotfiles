local utils = require("core.utils")
local neotest = require("neotest")
local neotest_rust = require("neotest-rust")
local neotest_jest = require("neotest-jest")

utils.load_mappings("neotest")
neotest.setup({
	adapters = {
		neotest_rust({
			dap_adapter = "lldb",
			args = { "--no-capture" },
		}),
		neotest_jest({}),
	},
})
