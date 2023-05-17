local dap = require("dap")
local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "~/.local/share/nvim/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		type = "codelldb",
		request = "launch",
	},
}
