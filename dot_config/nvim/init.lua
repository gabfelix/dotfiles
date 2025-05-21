-- These should always come first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split' -- Live substitution previews
vim.opt.scrolloff = 8
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local system_can_preview_markdown = function()
  return vim.fn.executable 'pandoc' == 1 and vim.fn.executable 'zathura' == 1 and vim.fn.executable 'pdflatex' == 1
end

local preview_markdown = function()
  if not system_can_preview_markdown() then
    error "Markdown preview dependencies not found ('pandoc' and 'zathura' and 'pdflatex')"
  end
  if vim.bo.filetype ~= 'markdown' then
    error 'Buffer filetype is not markdown'
  end

  local filename = '/tmp/nvim-md-' .. os.time() .. '.md' -- Markdown file
  local file = io.open(filename, 'w')
  if file then
    local buf = vim.api.nvim_get_current_buf()
    local lines = (vim.api.nvim_buf_get_lines(buf, 0, -1, false))
    file:write(table.concat(lines, '\n'))
    file:close()
    vim.fn.system('pandoc -t pdf "' .. filename .. '" | zathura -')
  else
    print('Failed to save buffer contents to "' .. filename .. '"')
  end
end

if system_can_preview_markdown() then
  -- Create :PreviewMarkdown
  vim.api.nvim_create_user_command('PreviewMarkdown', preview_markdown, {})

  -- Register shortcut for it when opening markdown files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      -- Set buffer-local keymap for Markdown
      vim.keymap.set('n', '<leader>p', preview_markdown, { buffer = true, desc = 'Preview Markdown' })
    end,
  })
end

-- Plugins 
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Colorscheme
		{ 
			"ellisonleao/gruvbox.nvim",
			priority = 1000,
			config = function(opts)
				require("gruvbox").setup({
					contrast = "hard", -- can be "hard", "soft" or empty string
					transparent_mode = true,
				})
				vim.opt.background = 'dark'
				vim.cmd.colorscheme 'gruvbox'
			end
		},
		-- File browser
		{
			'stevearc/oil.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
			config = function()
				require('oil').setup {
					default_file_explorer = true, -- Take over from netrw
					columns = { 'icon' },
					view_options = {
						show_hidden = true,
					},
					keymaps = {
						['zh'] = 'actions.toggle_hidden',
					},
				}
				vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory in Oil' })
			end,
		},
		{
			'echasnovski/mini.statusline',
			opts = {
				use_icons = true,
			},
			config = function(opts)
				local statusline = require 'mini.statusline'
				statusline.setup(opts)
				---@diagnostic disable-next-line: duplicate-set-field
				statusline.section_location = function()
					return '%2l:%-2v'
				end
			end,
		},
		{
			'nvim-telescope/telescope.nvim',
			event = 'VimEnter',
			branch = '0.1.x',
			dependencies = {
				'nvim-lua/plenary.nvim',
				{
					'nvim-telescope/telescope-fzf-native.nvim',
					build = 'make',
					cond = function()
						return vim.fn.executable 'make' == 1
					end,
				},
				{ 'nvim-telescope/telescope-ui-select.nvim' },
				{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
			},
			config = function()
				require('telescope').setup {
					extensions = {
						['ui-select'] = {
							require('telescope.themes').get_dropdown(),
						},
					},
					pickers = {
						find_files = {
							follow = true,
						},
					},
				}
				pcall(require('telescope').load_extension, 'fzf')
				pcall(require('telescope').load_extension, 'ui-select')

				local builtin = require 'telescope.builtin'
				vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
				vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
				vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
				vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
				vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
				vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
				vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
				vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
				vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
				vim.keymap.set('n', '<leader>sn', function()
					builtin.find_files { cwd = vim.fn.stdpath 'config' }
				end, { desc = '[S]earch [N]eovim files' })
			end,
		}
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
