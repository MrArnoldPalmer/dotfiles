vim.g.rustaceanvim = function()
	local mason_path = vim.fn.stdpath("data") .. "/mason"
	local extension_path = mason_path .. "/packages/codelldb/extension"
	local codelldb_path = mason_path .. "/bin/codelldb"
	local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
	local executors = require("rustaceanvim.executors")
	return {
		tools = {
			test_executor = executors.neotest,
		},
		server = {
			-- capabilities = require("cmp_nvim_lsp").default_capabilities(),
			on_attach = function()
				-- override some generic lsp mappings with RustLsp stuff
				local bufnr = vim.api.nvim_get_current_buf()
				vim.keymap.set("n", "<leader>ca", function()
					vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
				end, { silent = true, buffer = bufnr })

				vim.keymap.set("n", "K", function()
					require("rustaceanvim.hover_actions").hover_actions()
				end, { silent = true, buffer = bufnr })

				vim.keymap.set("n", "<F5>", function()
					local dap = require("dap")

					if dap.session() then
						dap.continue()
					else
						vim.cmd.RustLsp("debuggables") -- supports rust-analyzer's grouping
					end
				end, { silent = true, buffer = bufnr, desc = "Launch Debugger" })

				vim.keymap.set("n", "S-F5>", function()
					vim.cmd.RustLsp({ "debuggables", bang = true })
				end, { silent = true, buffer = bufnr, desc = "Rerun Debugger" })

				vim.keymap.set("n", "<F6>", function()
					vim.cmd.RustLsp("runnables")
				end, { silent = true, buffer = bufnr, desc = "Run" })

				vim.keymap.set("n", "<S-F6>", function()
					vim.cmd.RustLsp({ "runnables", bang = true })
				end, { silent = true, buffer = bufnr, desc = "Rerun last" })
			end,
			default_settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					files = {
						excludeDirs = { "build" },
					},
				},
			},
		},
		dap = {
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	}
end
