vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split' -- Live substitution previews
vim.opt.scrolloff = 8
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true

vim.cmd.colorscheme 'retrobox'

-- F7 to edit main config
vim.keymap.set('n', '<F7>', function()
	local config_dir = vim.fn.stdpath("config")
	vim.cmd("cd " .. config_dir)
	local init_file_path = config_dir .. "/init.lua"
	vim.cmd("edit " .. init_file_path)
end, { desc = 'Edit init.lua and change CWD' })

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			vim.system({ 'make' }, { cwd = ev.data.path })
		end
	end,
})

vim.pack.add({
	'https://github.com/nvim-mini/mini.surround',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/nvim-lua/plenary.nvim', -- telescope dependency
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

require('mini.surround').setup {
	custom_surroundings = {
		['('] = { output = { left = '( ', right = ' )' } },
		['['] = { output = { left = '[ ', right = ' ]' } },
		['{'] = { output = { left = '{ ', right = ' }' } },
		['<'] = { output = { left = '< ', right = ' >' } },
	},
	mappings = {
		add = 'ys',
		delete = 'ds',
		find = '',
		find_left = '',
		highlight = '',
		replace = 'cs',
		update_n_lines = '',
	},
	search_method = 'cover_or_next',
}
-- Remap adding surrounding to Visual mode selection
vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true, desc = 'Add surround to selection' })
-- Make special mapping for "add surrounding for line"
vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false, desc = 'Add surround to line' })

require('oil').setup {
	default_file_explorer = true, -- Take over from netrw
	columns = { 'icon' },
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		['zh'] = 'actions.toggle_hidden',
	},
}
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory in Oil' })

require('telescope').setup()
require('telescope').load_extension('fzf')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>g', builtin.live_grep)
vim.keymap.set('n', '<leader>b', builtin.buffers)
