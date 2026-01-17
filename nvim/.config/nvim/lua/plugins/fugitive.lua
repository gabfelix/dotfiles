return {
  'tpope/vim-fugitive',
  lazy = false,
  config = function()
    vim.keymap.set('n', '<leader>g', '<cmd>Git<CR>', { desc = 'Open fu[G]itive' })
  end,
}
