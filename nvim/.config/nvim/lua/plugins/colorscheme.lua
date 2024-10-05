return {
  'miikanissi/modus-themes.nvim',
  priority = 1000,
  config = function()
    vim.opt.background = 'dark'
    vim.cmd.colorscheme 'modus'
  end,
}
