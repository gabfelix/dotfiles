return {
  'echasnovski/mini.pick',
  version = '*',
  dependencies = {
    'echasnovski/mini.icons',
  },
  opts = {
    mappings = {
      choose = '<C-y>',
    },
  },
  config = function(_, opts)
    require('mini.pick').setup(opts)
    vim.keymap.set('n', '<leader>f', MiniPick.builtin.files, { desc = 'pick [f]iles' })
    vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.buffers, { desc = 'pick buffers' })
    vim.keymap.set('n', '<leader>g', MiniPick.builtin.grep_live, { desc = 'pick grep' })
  end,
}
