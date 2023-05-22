local dap = require("dap")
-- local dapui = require("dapui")
local cargo_inspector = require("custom.utils.cargo-inspector")

dap.adapters.lldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
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

if vim.fn.filereadable(".vscode/launch.json") then
	require("dap.ext.vscode").load_launchjs(nil, {
		lldb = { "rust" },
	})
end

-- dapui.setup()
-- dap.listeners.after.event_initialized["dapui_config"] = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end
