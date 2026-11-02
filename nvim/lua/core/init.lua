local opt = vim.opt
local g = vim.g

--- Setup clipboard for WSL
local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()

opt.clipboard = "unnamedplus"

-- Fall back to OSC 52 when no clipboard tool is available: remote/headless
-- hosts (e.g. over ssh in herdr), or WSL without win32yank.exe (e.g. nvim in
-- herdr in Windows Terminal). nvim only auto-enables OSC 52 when 'clipboard' is
-- empty, so set it explicitly; the terminal then sets the system clipboard.
-- herdr doesn't answer OSC 52 reads, so paste reads the Windows clipboard on
-- WSL, and otherwise returns the last copy (use the terminal's paste for
-- system text).
local function has(exe)
	return vim.fn.executable(exe) == 1
end
local has_native_clipboard = vim.fn.has("mac") == 1
	or vim.env.TMUX ~= nil
	or (is_wsl and has("win32yank.exe"))
	or (vim.env.WAYLAND_DISPLAY ~= nil and has("wl-copy"))
	or (vim.env.DISPLAY ~= nil and (has("xclip") or has("xsel")))
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
	local function windows_paste()
		local res = vim.system({
			"powershell.exe",
			"-NoLogo",
			"-NoProfile",
			"-NonInteractive",
			"-Command",
			"[Console]::OutputEncoding = [Text.Encoding]::UTF8; "
				.. "$c = Get-Clipboard -Raw; if ($c) { [Console]::Out.Write($c.Replace(\"`r\", \"\")) }",
		}, { text = true }):wait()
		if res.code ~= 0 then
			return nil
		end
		return vim.split(res.stdout or "", "\n", { plain = true })
	end
	local function paste(reg)
		return function()
			if is_wsl and has("powershell.exe") then
				local lines = windows_paste()
				if lines then
					-- Reuse the regtype if this is still our own last copy.
					local last = last_copy[reg]
					if last and vim.deep_equal(last[1], lines) then
						return last
					end
					return lines
				end
			end
			return last_copy[reg] or { {}, "v" }
		end
	end
	g.clipboard = {
		name = is_wsl and "OSC 52 + powershell" or "OSC 52",
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
