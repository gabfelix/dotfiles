return {
	"mcchrish/zenbones.nvim",
	dependencies = { "lualine.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.zenbones_compat = 1 -- Don't require lush.nvim
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		require("lualine").setup({
			theme = "zenbones"
		})
		vim.cmd.colorscheme("zenbones")
	end,
}
