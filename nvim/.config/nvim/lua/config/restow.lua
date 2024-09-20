local deployed_path = vim.fn.expand('$HOME/.config/nvim')
local dotfiles_path = vim.fn.expand('$HOME/Code/dotfiles')
local script_path = dotfiles_path .. '/stowit.sh'
local augroup_name = 'DeployNvimDotfiles'


-- Clean up broken symlinks in deployed config on startup
if vim.fn.filereadable(deployed_path) then
	local cmd = 'find ' .. deployed_path .. ' -type l ! -exec test -e {} \\; -delete'
	vim.fn.system(cmd)
end

-- Redeploy nvim config with stow wrapper script on change
vim.api.nvim_create_augroup(augroup_name, { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*',
	callback = function()
		local file_path = vim.fn.expand('%:p')
		if vim.fn.filereadable(dotfiles_path) and vim.fn.filereadable(script_path) and file_path:match('^' .. dotfiles_path .. '/') then
			local original_cwd = vim.fn.getcwd()
			vim.fn.chdir(dotfiles_path)
			vim.fn.system('sh ' .. script_path .. ' nvim')
			vim.fn.chdir(original_cwd)
		end
	end
})
