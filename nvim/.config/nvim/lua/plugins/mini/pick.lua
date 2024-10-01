return {
  'echasnovski/mini.pick',
  version = false,
  dependencies = {
    { 'echasnovski/mini.extra', version = false }, -- More pickers
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

    require('mini.extra').setup {}
    local lsp_document_symbols = function()
      MiniExtra.pickers.lsp { scope = 'document_symbol' }
    end

    local lsp_references = function()
      MiniExtra.pickers.lsp { scope = 'references' }
    end

    vim.keymap.set('n', '<leader>ld', lsp_document_symbols, { desc = 'pick [l]SP [d]ocument symbols' })
    vim.keymap.set('n', '<leader>lr', lsp_references, { desc = 'pick [l]SP [r]eferences' })
  end,
}
