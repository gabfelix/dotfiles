vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

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

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Quickfix
vim.keymap.set('n', '<leader>q', '<cmd>botright copen<CR>', { noremap = true, desc = 'Open Quickfix list (bottom right)' })
vim.keymap.set('n', '<leader>Q', '<cmd>cclose<CR>', { noremap = true, desc = 'Close Quickfix list' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next Quickfix Item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous Quickfix Item' })
-- Open/close location list
vim.keymap.set('n', '<leader>l', '<cmd>lopen<CR>', { noremap = true, desc = 'Open Location list' })
vim.keymap.set('n', '<leader>L', '<cmd>lclose<CR>', { noremap = true, desc = 'Close Location list' })

-- Tabs
vim.keymap.set('n', '<leader>t', '<cmd>tabnew<CR>', { noremap = true, desc = 'Open new empty tab' })
vim.keymap.set('n', '<leader>T', '<cmd>tabclose<CR>', { noremap = true, desc = 'Close current tab' })

-- F7 to edit main config
vim.keymap.set('n', '<F7>', function()
    local config_dir = vim.fn.stdpath("config")
    vim.cmd("cd " .. config_dir)
    local init_file_path = config_dir .. "/init.lua"
    vim.cmd("edit " .. init_file_path)
end, { desc = 'Edit init.lua and change CWD' })
