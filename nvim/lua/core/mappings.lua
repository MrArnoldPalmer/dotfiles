local M = {}

M.general = {
	i = {
		-- go to  beginning and end
		["<C-b>"] = { "<ESC>^i", "Beginning of line" },
		["<C-e>"] = { "<End>", "End of line" },

		-- navigate within insert mode
		["<C-h>"] = { "<Left>", "Move left" },
		["<C-l>"] = { "<Right>", "Move right" },
		["<C-j>"] = { "<Down>", "Move down" },
		["<C-k>"] = { "<Up>", "Move up" },
	},

	n = {
		["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
		-- switch between windows
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },

		-- save
		["<C-s>"] = { "<cmd> w <CR>", "Save file" },

		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

		-- line numbers
		["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },

		-- new buffer
		["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
		-- next buffer
		["<tab>"] = {
			"<cmd>bnext<cr>",
			"Goto next buffer",
		},
		-- prev buffer
		["<S-tab>"] = {
			"<cmd>bprevious<cr>",
			"Goto prev buffer",
		},
		["<leader>x"] = {
			function()
				require("mini.bufremove").delete()
			end,
			"Close Buffer",
		},

		-- format buffer
		["<leader>fm"] = {
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			"Format Buffer",
		},
	},

	v = {
		["<"] = { "<gv", "Indent line" },
		[">"] = { ">gv", "Indent line" },
	},

	x = {
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

M.comment = {
	-- toggle comment in both modes
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
}

M.Oil = {
	n = {
		["-"] = {
			function()
				require("oil").open()
			end,
			"Open buffer parent directory",
		},
	},
}

M.lspconfig = {
	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
	n = {
		["E"] = {
			function()
				vim.diagnostic.open_float()
			end,
			"Show diagnostic detail",
		},
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"LSP hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"LSP implementation",
		},

		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP definition type",
		},

		["<leader>rn"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},

		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},

		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},

		["<leader>lf"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"Floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ float = { border = "rounded" } })
			end,
			"Goto prev",
		},

		["]d"] = {
			function()
				vim.diagnostic.goto_next({ float = { border = "rounded" } })
			end,
			"Goto next",
		},

		["<leader>q"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"Diagnostic setloclist",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"Add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"Remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
	},

	v = {
		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},
	},
}

M.dap = {
	n = {
		["<F5>"] = {
			function()
				require("dap").continue()
			end,
			"Launch debugger",
		},
		["<F10>"] = {
			function()
				require("dap").step_over()
			end,
			"Debugger step over",
		},
		["<F11>"] = {
			function()
				require("dap").step_into()
			end,
			"Debugger step into",
		},
		["<F12>"] = {
			function()
				require("dap").step_out()
			end,
			"Debugger step out",
		},
		["<Leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		["<Leader>dB"] = {
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"Set breakpoint condition",
		},
		["<Leader>lp"] = {
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			"Set log point",
		},
		["<Leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"Debugger open repl",
		},
		["<Leader>dl"] = {
			function()
				require("dap").run_last()
			end,
			"Debugger run last",
		},
		["<Leader>df"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"Debugger show frames",
		},
		["<Leader>ds"] = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"Debugger show scopes",
		},
	},
}

M.telescope = {
	n = {
		-- find
		["<leader>ff"] = { "<cmd>Telescope find_files <CR>", "Find files" },
		["<leader>fa"] = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
		-- ["<leader>fw"] = { "<cmd>Telescope live_grep <CR>", "Live grep" },
		["<leader>fb"] = { "<cmd>Telescope buffers <CR>", "Find buffers" },
		["<leader>fh"] = { "<cmd>Telescope help_tags <CR>", "Help page" },
		["<leader>fo"] = { "<cmd>Telescope oldfiles <CR>", "Find oldfiles" },
		["<leader>fz"] = { "<cmd>Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

		-- git
		["<leader>cm"] = { "<cmd>Telescope git_commits <CR>", "Git commits" },
		["<leader>gt"] = { "<cmd>Telescope git_status <CR>", "Git status" },
		["<leader>ma"] = { "<cmd>Telescope marks <CR>", "telescope bookmarks" },
		["<leader>fr"] = {
			function()
				require("telescope.builtin").resume()
			end,
			"Finder resume",
		},
		["<leader>fd"] = {
			function()
				require("telescope.builtin").diagnostics()
			end,
			"Find diagnostics",
		},
		["<leader>fw"] = {
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			"Live grep",
		},
	},
}

M.whichkey = {
	n = {
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"Which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"Which-key query lookup",
		},
	},
}

M.spectre = {
	n = {
		["<leader>S"] = {
			function()
				require("spectre").toggle()
			end,
			"Toggle Spectre",
		},
		["<leader>sw"] = {
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			"Search Current Word",
		},
		["<leader>sp"] = {
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			"Search Current File",
		},
	},
	v = {
		["<leader>sw"] = {
			function()
				require("spectre").open_visual()
			end,
			"Search Current Word",
		},
	},
}

return M
