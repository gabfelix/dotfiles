return {
	"miikanissi/modus-themes.nvim",
	dependencies = { "lualine.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		vim.opt.background = "dark"
		vim.cmd.colorscheme("modus_vivendi")
	end,
}
