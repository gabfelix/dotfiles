-- Use markdown for editing Calcurse todos
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '/tmp/calcurse*', '~/.local/share/calcurse/notes/*' },
  callback = function()
    vim.bo.filetype = 'markdown'
  end,
})
