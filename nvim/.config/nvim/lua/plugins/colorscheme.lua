return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.o.background = 'dark'
    -- You can also load 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight-night'
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
