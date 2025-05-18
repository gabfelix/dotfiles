return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- enable icons
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['zh'] = 'actions.toggle_hidden',
    },
    columns = { 'icon' },
  },
  init = function()
    vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory in Oil' })
  end,
}
