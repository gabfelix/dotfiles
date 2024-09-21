return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim',
  },
  config = function(_, opts)
    require('neogit').setup(opts)
    vim.keymap.set('n', '<leader>G', require('neogit').open, { desc = 'Open Neo[G]it' })
  end,
}
