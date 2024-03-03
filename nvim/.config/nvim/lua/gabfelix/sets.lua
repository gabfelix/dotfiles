local opts = {
	exrc = true, -- Source vimrc in current directory if there is one
	number = true,
	relativenumber = true,
	hidden = true, -- Switch from unsaved edited buffer
	completeopt = {'menuone', 'noinsert', 'noselect'},
	laststatus = 3, -- All splits use the same status line
	ignorecase = true,
	smartcase = true,
	tabstop = 4,
	shiftwidth = 4,
	scrolloff = 8,
	sidescrolloff = 8,
	cursorline = true
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end
