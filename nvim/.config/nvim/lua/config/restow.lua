local deployed_path = vim.fn.expand '$HOME/.config/nvim'
local dotfiles_path = vim.fn.expand '$HOME/dev/dotfiles'

-- Clean up broken symlinks in deployed config on startup
if vim.fn.filereadable(deployed_path) then
  local cmd = 'find ' .. deployed_path .. ' -type l ! -exec test -e {} \\; -delete'
  vim.fn.system(cmd)
end

-- Redeploy nvim config on change to nvim module
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup("GabfelixRestow", { clear = true })
  pattern = dotfiles_path .. '/nvim/**',
  callback = function()
    local cmd = string.format('stow -v --no-folding -d %s nvim -t ~', dotfiles_path)
    vim.cmd('!' .. cmd)
  end,
})
