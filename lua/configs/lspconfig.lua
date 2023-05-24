local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilites

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript" },
	root_dir = lspconfig.util.root_pattern("tsconfig.json"),
})
