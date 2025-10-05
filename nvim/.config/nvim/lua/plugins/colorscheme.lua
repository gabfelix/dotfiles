return {
  'tiesen243/vercel.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('vercel').setup {
      italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
        bufferline = false,
      },
    }
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'vercel'
  end,
}
