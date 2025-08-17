local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		-- Uncomment next line to use 'stable' branch
		-- '--branch', 'stable',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('mini.icons').setup()
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

-- Setup mini.surround to use tpope/vim-surround keybindings
require('mini.surround').setup({
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
})

require('mini.files').setup({
	windows = {
		preview = true,
		width_preview = 50,
	}
})

vim.keymap.set('n', '-', MiniFiles.open)

-- Remap adding surrounding to Visual mode selection
vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

-- Make special mapping for "add surrounding for line"
vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })

require('mini.statusline').setup()

require('mini.pick').setup()
vim.keymap.set('n', '<leader>sf', MiniPick.builtin.files)
vim.keymap.set('n', '<leader>sg', MiniPick.builtin.grep_live)
vim.keymap.set('n', '<leader>sb', MiniPick.builtin.buffers)

-- Plugins (other than mini)
require('mini.deps').setup({ path = { package = path_package } } )

local add = MiniDeps.add

add({
	source = 'ellisonleao/gruvbox.nvim',
})
require('gruvbox').setup({
	contrast = "hard",
})
vim.opt.background = 'dark'
vim.cmd.colorscheme 'gruvbox'
