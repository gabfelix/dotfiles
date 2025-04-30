return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    vim.opt.background = 'dark'
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'gruvbox'
  end,
}
