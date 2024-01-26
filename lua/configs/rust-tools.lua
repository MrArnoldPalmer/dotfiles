vim.g.rustaceanvim = function()
  local rt = require("rustaceanvim")
  local utils = require("core.utils")
  local configs = require("plugins.configs.lspconfig")
  local on_attach = configs.on_attach
  local capabilities = configs.capabilities

  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local extension_path = mason_path .. "/packages/codelldb/extension"
  local codelldb_path = mason_path .. "/bin/codelldb"
  local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
  return {
    server = {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    },
    dap = {
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end
