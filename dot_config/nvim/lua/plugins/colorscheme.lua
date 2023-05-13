local M = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		vim.opt.termguicolors = true
		local onedark = require("onedark")
		onedark.setup(opts)
		onedark.load()
	end,
}

return M
