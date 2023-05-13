vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd('colorscheme gruvbox')

require('lualine').setup {
	globalstatus = true,
	options = {
		theme = 'gruvbox'
	}
}
