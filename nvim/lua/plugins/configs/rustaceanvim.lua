vim.g.rustaceanvim = function()
	local mason_path = vim.fn.stdpath("data") .. "/mason"
	local extension_path = mason_path .. "/packages/codelldb/extension"
	local codelldb_path = mason_path .. "/bin/codelldb"
	local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
	return {
		dap = {
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	}
end
