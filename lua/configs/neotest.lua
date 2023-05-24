local neotest = require("neotest")
local neotest_rust = require("neotest-rust")
local neotest_jest = require("neotest-jest")

neotest.setup({
	adapters = {
		neotest_rust({
			dap_adapter = "lldb",
		}),
		neotest_jest({}),
	},
})
