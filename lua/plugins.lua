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
				"codelldb",
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
		config = function()
			require("nvim-surround").setup()
		end,
	},
}

return plugins
