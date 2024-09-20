return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>G', '<cmd>Git<cr>', { desc = 'fu[G]itive' })
    end,
}
