local M = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		local gruvbox = require("gruvbox")
		gruvbox.setup(opts)
		vim.cmd.colorscheme('gruvbox')
	end,
}

return M
