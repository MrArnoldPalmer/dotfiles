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
			require("plugins.configs.lspconfig")
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		config = function()
			require("plugins.configs.rustaceanvim")
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
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
			require("plugins.configs.none-ls")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
				integrations = {
					gitsigns = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
					mason = true,
					neotest = true,
					notify = true,
					cmp = true,
					dap = true,
					dap_ui = true,
					native_lsp = {
						enabled = true,
					},
					treesitter = true,
					octo = true,
					telescope = {
						enabled = true,
					},
					lsp_trouble = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
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
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
		config = function()
			require("bufferline").setup({
				options = {
					highlights = require("catppuccin.groups.integrations.bufferline").get(),
					diagnostics = "nvim_lsp",
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"rcarriga/nvim-notify",
		init = function()
			vim.notify = require("notify")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup()
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.configs.nvim-dap")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
	{
		"numToStr/Comment.nvim",
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
}

return plugins
