return {
  'craftzdog/solarized-osaka.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    require('solarized-osaka').setup {
      transparent = false,
    }
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'solarized-osaka'
  end,
}
