local utils = require("core.utils")

require("lspsaga").setup({
	finder = {
		keys = {
			vsplit = "<c-v>",
			split = "<c-x>",
			toggle_or_open = "<cr>",
		},
	},
	outline = {
		keys = {
			toggle_or_jump = "<cr>",
		},
	},
	lightbulb = {
		sign_priority = -1,
	},
	ui = {
		title = false,
		border = "rounded",
	},
})

utils.load_mappings("lspsaga")
