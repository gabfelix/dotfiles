vim.g.mapleader = ' '
require('plugins')

vim.opt.exrc = true -- Source vimrc in current directory if there is one
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true -- Switch from unsaved edited buffer
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.laststatus = 3 -- All splits use the same status line
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

require('theme/onedark')

require('plugins/telescope')
require('plugins/treesitter')
require('plugins/lsp')
