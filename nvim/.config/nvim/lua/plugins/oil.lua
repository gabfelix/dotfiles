return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      columns = { 'icon' },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['zh'] = 'actions.toggle_hidden',
      },
    }
    vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory in Oil' })
  end,
}
