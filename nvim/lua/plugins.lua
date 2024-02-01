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
		config = function()
			require("mason").setup({
				ensure_installed = {
					"rust-analyzer",
					"stylua",
					"typescript-language-server",
					"js-debug-adapter",
					"codelldb",
					"lua-language-server",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("configs/lspconfig")
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		config = function()
			require("configs/rust-tools")
		end,
		version = "^4",
		ft = { "rust" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			extensions_list = { "fzf", "live_grep_args" },
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build =
				"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("configs/none-ls")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin/nvim",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}

return plugins
