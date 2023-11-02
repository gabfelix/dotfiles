return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		vim.opt.termguicolors = true
		local theme = require("onedark")
		theme.setup({
			style = 'dark'
		})
		theme.load()
	end,
}
