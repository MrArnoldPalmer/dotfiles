local plugins = {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"rust",
				"toml",
				"typescript",
				"javascript",
				"markdown",
				"markdown_inline",
				"json",
				"go",
				"gomod",
				"java",
				"dockerfile",
				"python",
				"dap_repl",
			},
		},
		dependencies = {
			{
				"LiadOz/nvim-dap-repl-highlights",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"rustfmt",
				"stylua",
				"typescript-language-server",
				"js-debug-adapter",
				"codelldb",
				"lua-language-server",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.nvim-dap")
		end,
		dependencies = {
			{
				"nvim-telescope/telescope-dap.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
			{
				"LiadOz/nvim-dap-repl-highlights",
				config = function()
					require("nvim-dap-repl-highlights").setup()
				end,
			},
			{
				"rcarriga/cmp-dap",
				config = function()
					require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
						sources = {
							{ name = "dap" },
						},
					})
				end,
			},
		},
	},
	{
		"folke/trouble.nvim",
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("custom.configs.lspsaga")
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			{ "antoinemadec/FixCursorHold.nvim" },
			{ "rouge8/neotest-rust" },
			{ "nvim-neotest/neotest-jest" },
		},
		config = function()
			require("custom.configs.neotest")
		end,
		lazy = false,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			extensions_list = { "themes", "terms", "fzf", "neoclip" },
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{
				"AckslD/nvim-neoclip.lua",
				config = function()
					require("neoclip").setup()
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
		},
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		config = function()
			require("octo").setup()
		end,
	},
}

return plugins
