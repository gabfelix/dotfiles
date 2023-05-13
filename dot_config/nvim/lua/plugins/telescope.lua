local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
	},
	keys = {
			{ '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>" },
			{ '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
			{ '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>" },
			{ '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzy_native")
	end
}

return M
