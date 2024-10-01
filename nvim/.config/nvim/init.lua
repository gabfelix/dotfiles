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

vim.g.have_nerd_font = true
-- Redeploys symlinks to your nvim config using GNU stow. It should handle
-- adding, editing and removing. Very specific to my machine, others may not
-- want this.
vim.g.restow_enabled = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically redeploy nvim config
if vim.g.restow_enabled and vim.fn.executable('stow') ~= 0 then
  require 'config.restow'
end

-- Plugins
local bootstrap_mini = function()
  local path_package = vim.fn.stdpath('data') .. '/site/'
  local mini_path = path_package .. 'pack/deps/start/mini.nvim'
  if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
  end
end

bootstrap_mini()
require('mini.deps').setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

if vim.g.have_nerd_font then
  now(function()
    require('mini.icons').setup()
  end)
end

now(function()
  require('mini.statusline').setup {
    use_icons = vim.g.have_nerd_font,
  }
end)

-- mini.pick
later(function()
    require('mini.pick').setup {
        mappings = {
            choose = '<C-y>'
        }
    }
    vim.keymap.set('n', '<leader>f', MiniPick.builtin.files)
    vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.buffers)
    vim.keymap.set('n', '<leader>g', MiniPick.builtin.grep_live)

    local lsp_picker = require('mini.extra').pickers.lsp
    vim.keymap.set('n', '<leader>ld', function() lsp_picker { scope = 'document_symbol' } end)
    vim.keymap.set('n', '<leader>lr', function() lsp_picker { scope = 'references' } end)
end)

-- mini.pairs
later(function()
  require('mini.pairs').setup()
end)

-- oil.nvim
add({
  source = 'stevearc/oil.nvim'
})
require('oil').setup {
      columns = { 'icon' },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['zh'] = 'actions.toggle_hidden',
      },
}
vim.keymap.set('n', '-', vim.cmd.Oil)

-- treesitter
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'vimdoc' },
  highlight = { enable = true },
})
