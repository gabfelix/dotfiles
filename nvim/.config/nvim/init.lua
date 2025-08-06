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
require('mini.basics').setup()
-- override mini.basics with the stuff I like
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

require('mini.base16').setup({
	palette = {
		base00 = "#002b36",
		base01 = "#073642",
		base02 = "#586e75",
		base03 = "#657b83",
		base04 = "#839496",
		base05 = "#93a1a1",
		base06 = "#eee8d5",
		base07 = "#fdf6e3",
		base08 = "#dc322f",
		base09 = "#cb4b16",
		base0A = "#b58900",
		base0B = "#859900",
		base0C = "#2aa198",
		base0D = "#268bd2",
		base0E = "#6c71c4",
		base0F = "#d33682",
	}
})

require('mini.pick').setup()

-- Plugins (other than mini)
require('mini.deps').setup({ path = { package = path_package } } )
local add = MiniDeps.add
