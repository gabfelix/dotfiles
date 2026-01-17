return {
  'gabfelix/mudworld',
  priority = 1000,
  config = function()
    require('mudworld').setup()
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'mudworld'
  end,
}
