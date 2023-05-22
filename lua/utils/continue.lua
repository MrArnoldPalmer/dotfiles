-- Function that reloads launch.json when launching debugger
local function continue()
	if vim.fn.filereadable(".vscode/launch.json") then
		require("dap.ext.vscode").load_launchjs(nil, {
			lldb = { "rust" },
		})
	end
	require("dap").continue()
end

return continue
