require("neotest").setup({
	adapters = {
		require("neotest-rust")({
			dap_adapter = "lldb",
		}),
		require("neotest-jest")({}),
	},
})
