local dap = require("dap")
local cargo_inspector = require("utils.cargo-inspector")

local mason_path = vim.fn.stdpath("data") .. "/mason"

dap.adapters.lldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_path .. "/bin/codelldb",
		args = { "--port", "${port}" },
	},
	enrich_config = function(config, on_config)
		-- If the configuration(s) in `launch.json` contains a `cargo` section
		-- send the configuration off to the cargo_inspector.
		if config["cargo"] ~= nil then
			on_config(cargo_inspector(config))
		end
	end,
}
dap.adapters.codelldb = dap.adapters.lldb

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		-- args = {mason_path .. "/bin/js-debug-adapter", "${port}"},
		args = { mason_path .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.typescript = dap.configurations.javascript

if vim.fn.filereadable(".vscode/launch.json") then
	require("dap.ext.vscode").load_launchjs(nil, {
		lldb = { "rust" },
		["pwa-node"] = { "javascript", "typescript" },
	})
end
