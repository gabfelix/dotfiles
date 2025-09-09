return {
  'Thiago4532/mdmath.nvim',
  ft = 'markdown',
  cond = vim.fn.executable 'magick' and vim.fn.executable 'rsvg-convert',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = { filetypes = { 'markdown' } },
}
