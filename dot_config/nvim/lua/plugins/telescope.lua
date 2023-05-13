-- Let's avoid all this typing)
local function nnoremap_wrapper(key, cmd)
	vim.api.nvim_set_keymap('n', key, cmd, {noremap = true})
end

nnoremap_wrapper('<leader>ff', '<cmd> lua require(\'telescope.builtin\').find_files()<cr>')
nnoremap_wrapper('<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
nnoremap_wrapper('<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
nnoremap_wrapper('<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
