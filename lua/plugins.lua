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
		"simrat39/rust-tools.nvim",
		config = function()
			require("custom.configs.rust-tools")
		end,
		dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap", "nvim-lua/plenary.nvim" },
		ft = { "rust" },
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.nvim-dap")
		end,
		dependencies = { "nvim-telescope/telescope-dap.nvim" },
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"LiadOz/nvim-dap-repl-highlights",
		config = function()
			require("nvim-dap-repl-highlights").setup()
		end,
		dependencies = { "mfussenegger/nvim-dap" },
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
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},
	{
		"folke/trouble.nvim",
		lazy = false,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("custom.configs.lspsaga")
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			{ "rouge8/neotest-rust" },
			{ "nvim-neotest/neotest-jest" },
			{ "mfussenegger/nvim-dap" },
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
			extensions_list = { "themes", "terms", "fzf", "neoclip", "live_grep_args", "file_browser", "dap" },
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		config = function()
			require("octo").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{
				"<leader>gvh",
				":DiffviewFileHistory %<CR>",
				desc = "Diffview history of the current file",
			},
			{
				"<leader>gvo",
				":DiffviewOpen -- %<CR>",
				desc = "Open diffview for the current file",
			},
			{
				"<leader>gvm",
				":DiffviewOpen upstream/main %<CR>",
				desc = "Open diffview  against upstream/main",
			},
			{
				"<leader>gvc",
				":DiffviewClose<CR>",
				desc = "Close diffview",
			},
		},
	},
	{
		"ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}

return plugins
