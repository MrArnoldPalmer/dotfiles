local opt = vim.opt
local g = vim.g

--- Setup clipboard for WSL
local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()

opt.clipboard = "unnamedplus"

-- Remote/headless hosts (e.g. over ssh in herdr) have no native clipboard, and
-- nvim only auto-enables OSC 52 when 'clipboard' is empty. Copy via OSC 52 so
-- the terminal sets the system clipboard. herdr doesn't answer OSC 52 reads, so
-- paste returns the last copy (use the terminal's paste for system text).
local has_native_clipboard = vim.fn.has("mac") == 1
	or is_wsl
	or vim.env.TMUX ~= nil
	or vim.env.DISPLAY ~= nil
	or vim.env.WAYLAND_DISPLAY ~= nil
if not has_native_clipboard then
	local osc52 = require("vim.ui.clipboard.osc52")
	local last_copy = {}
	local function copy(reg)
		local send = osc52.copy(reg)
		return function(lines, regtype)
			last_copy[reg] = { lines, regtype }
			send(lines)
		end
	end
	local function paste(reg)
		return function()
			return last_copy[reg] or { {}, "v" }
		end
	end
	g.clipboard = {
		name = "OSC 52",
		copy = { ["+"] = copy("+"), ["*"] = copy("*") },
		paste = { ["+"] = paste("+"), ["*"] = paste("*") },
	}
end

--- Lots of stuff I stole from NvChad ---
-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.fixeol = false

-- opt.clipboard = opt.clipboard + "unnamedplus"
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.hidden = false

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
