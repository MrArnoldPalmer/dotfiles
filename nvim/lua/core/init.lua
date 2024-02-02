local opt = vim.opt
local g = vim.g

--- Setup clipboard for WSL
local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()

if is_wsl then
	g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
	}
end

--- Lots of stuff I stole from NvChad ---
-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = " "

-- load mappings
local mappings = require("core.mappings")
local merge_tb = vim.tbl_deep_extend
for _, sect in pairs(mappings) do
	for mode, mode_values in pairs(sect) do
		local default_opts = merge_tb("force", { mode = mode }, {})
		for keybind, mapping_info in pairs(mode_values) do
			local opts = merge_tb("force", default_opts, {})

			mapping_info.opts, opts.mode = nil, nil
			opts.desc = mapping_info[2]

			vim.keymap.set(mode, keybind, mapping_info[1], opts)
		end
	end
end
