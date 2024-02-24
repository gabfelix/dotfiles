return {
	"mcchrish/zenbones.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.zenbones_compat = 1
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		vim.cmd.colorscheme("zenbones")
	end,
}
