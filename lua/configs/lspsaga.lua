local keys = {
	vsplit = "<c-v>",
	split = "<c-x>",
	expand_or_jump = "<cr>",
}

require("lspsaga").setup({
	finder = {
		keys = keys,
	},
	outline = {
		keys = keys,
	},
	lightbulb = {
		sign_priority = -1,
	},
	ui = {
		title = false,
		border = "rounded",
	},
})
