return {
  'miikanissi/modus-themes.nvim',
  priority = 1000,
  init = function()
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'modus'
  end,
}
