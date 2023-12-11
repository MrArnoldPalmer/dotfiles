local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

require("typescript-tools").setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
		},
	},
})
