-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("bufferline").setup{}
require("lualine").setup {
  options = {
    theme = "material"
  }
}

require('material').setup({
  lualine_style = 'default'
})

-- empty setup using defaults
require("nvim-tree").setup()
