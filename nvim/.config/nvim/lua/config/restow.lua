local deployed_path = vim.fn.expand('$HOME/.config/nvim')
local dotfiles_path = vim.fn.expand('$HOME/Code/dotfiles')

-- Clean up broken symlinks in deployed config on startup
if vim.fn.filereadable(deployed_path) then
	local cmd = 'find ' .. deployed_path .. ' -type l ! -exec test -e {} \\; -delete'
	vim.fn.system(cmd)
end

-- Redeploy nvim config with stow wrapper script on change
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = dotfiles_path .. '/**',
	callback = function()
		local cmd = string.format('stow -v --no-folding -d %s nvim -t ~', dotfiles_path)
		vim.cmd('!' .. cmd)
	end
})
