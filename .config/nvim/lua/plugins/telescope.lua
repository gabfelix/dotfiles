local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim" },
	},
	keys = {
			{ '<leader>ff', function() require('telescope.builtin').find_files() end },
			{ '<leader>fg', function() require('telescope.builtin').live_grep() end },
			{ '<leader>fb', function() require('telescope.builtin').buffers() end },
			{ '<leader>fh', function() require('telescope.builtin').help_tags() end },
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf_native")
	end
}

return M
