local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
	formatting.rustfmt.with({
    extra_args = { "--edition", "2021" },
  }),
	formatting.eslint,
	formatting.stylua,
	lint.shellcheck,
	null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
