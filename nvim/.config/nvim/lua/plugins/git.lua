return {
  'tpope/vim-fugitive',
  lazy = false,
  cond = vim.fn.executable 'git',
  config = function()
    vim.keymap.set('n', '<leader>G', ':Git<CR>')
  end,
}
