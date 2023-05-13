vim.opt.termguicolors = true
vim.cmd('colorscheme onedark')

require('lualine').setup {
	globalstatus = true,
	options = {
		theme = 'onedark',
		icons_enabled = false,
		component_separators = { left = '', right = ''}
	}
}
