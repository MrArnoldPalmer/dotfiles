local rt = require("rust-tools")
local utils = require("core.utils")
local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local mason_path = vim.fn.stdpath("data") .. "/mason"
local extension_path = mason_path .. "/packages/codelldb/extension"
local codelldb_path = mason_path .. "/bin/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

local opts = {
	server = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			-- utils.load_mappings("rust_tools", { buffer = bufnr })
		end,
		capabilities = capabilities,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}

-- Normal setup
require("rust-tools").setup(opts)
