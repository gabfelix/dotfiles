local M = {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-refactor",
	},
	build = ":TSUpdate",
	opts = {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		autopairs = { enable = true },
		autotag = { enable = true },
		indent = { enable = true },
		ensure_installed = {"c", "cpp", "python", "markdown", "lua", "json", "javascript", "typescript", "rust"},
        sync_install = true,
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}

return M
