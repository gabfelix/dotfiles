return {
	"luisiacc/gruvbox-baby",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		require("lualine").setup({
			theme = "gruvbox-baby"
		})
		vim.cmd.colorscheme("gruvbox-baby")
	end,
}
