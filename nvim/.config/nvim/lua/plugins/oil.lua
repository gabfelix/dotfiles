return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = function()
    require('oil').setup {
      default_file_explorer = true, -- Take over from netrw
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
