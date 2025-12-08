return {
  'echasnovski/mini.surround',
  lazy = false,
  opts = {},
  config = function()
    -- tpope/vim-surround keybinds
    require('mini.surround').setup {
      custom_surroundings = {
        ['('] = { output = { left = '( ', right = ' )' } },
        ['['] = { output = { left = '[ ', right = ' ]' } },
        ['{'] = { output = { left = '{ ', right = ' }' } },
        ['<'] = { output = { left = '< ', right = ' >' } },
      },
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',
      },
      search_method = 'cover_or_next',
    }

    -- Remap adding surrounding to Visual mode selection
    vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true, desc = 'Add surround to selection' })
    -- Make special mapping for "add surrounding for line"
    vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false, desc = 'Add surround to line' })
  end,
}
