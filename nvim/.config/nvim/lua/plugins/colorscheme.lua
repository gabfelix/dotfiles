return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('gruvbox').setup {
      contrast = 'hard',
    }
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
