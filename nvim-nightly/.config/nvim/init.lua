vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split' -- Live substitution previews (really good)
vim.opt.scrolloff = 8
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<F7>', function()
	vim.cmd('edit ' .. vim.fn.stdpath('config') ..  '/init.lua')
end)

vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_animation_length = 0
-- Open in %USERPROFILE% if I just open Neovide on Windows
if vim.g.neovide and vim.fn.has("win32") and vim.fn.argc() == 0 then
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		callback = function()
			vim.api.nvim_set_current_dir(vim.fn.expand("~"))
		end,
	})
end
vim.o.guifont = 'Hack:h14'

-- PLUGINS
local github = function(url)
	return 'https://github.com/' .. url
end

vim.pack.add({
	github 'gabfelix/mudworld.git',
	github 'nvim-mini/mini.surround',
	github 'nvim-lua/plenary.nvim', -- telescope dep
	github 'nvim-mini/mini.pairs',
	github 'stevearc/oil.nvim',
	{ src = github 'nvim-telescope/telescope.nvim', version = '0.1.8' },
})

require('mudworld').setup({
	italics = false,
	bold = true
})
vim.cmd.colorscheme 'mudworld'

-- tpope settings for mini.surround
require('mini.surround').setup {
	custom_surroundings = {
		['('] = { output = { left = '( ', right = ' )' } },
		['['] = { output = { left = '[ ', right = ' ]' } },
		['{'] = { output = { left = '{ ', right = ' }' } },
		['<'] = { output = { left = '< ', right = ' >' } },
	},
	mappings = {
		add = 'ys',
		delete = 'ds',
		find = '',
		find_left = '',
		highlight = '',
		replace = 'cs',
		update_n_lines = '',vim.api.nvim_create_autocmd({ "FileType" }, {
  -- The autocmd will run when one of these filetypes is detected
  pattern = { "html", "javascriptreact", "typescriptreact", "jsx", "tsx" },
  
  -- The autocmd is buffer-local (it runs once per buffer)
  group = vim.api.nvim_create_augroup("MiniPairsHtmlTags", { clear = true }),

  callback = function(opts)
    -- Check if MiniPairs is available
    if require("mini.pairs") then
      local MiniPairs = require("mini.pairs")

      -- Define the pairing rule for the '<' key
      local pair_info = {
        action = "open",
        pair = "<>",
        action_close = "<BS>",
      }

      -- Apply the buffer-local mapping to the current buffer (opts.buf)
      MiniPairs.map_buf(opts.buf, "i", "<", pair_info)
    end
  end,
})
	},
	search_method = 'cover_or_next',
}

-- Remap adding surrounding to Visual mode selection
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

-- Make special mapping for "add surrounding for line"
vim.keymap.set('n', 'yss', 'ys_', { noremap = false })

require "telescope".setup({
	pickers = {
		buffers = {
			-- default to navigating buffers with movement keys instead of typing in
			-- prompt
			initial_mode = 'normal',
		}
	},
	defaults = {
		preview = false,
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = { "", "", "", "", "", "", "", "" },
		path_displays = "smart",
		layout_strategy = "horizontal",
		layout_config = {
			height = { padding = 0 },
			width = { padding = 0 },
			prompt_position = "top",
			preview_cutoff = 0,
		}
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>f" , builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>g" , builtin.live_grep , { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>b" , builtin.buffers   , { desc = "Telescope buffers"   })
vim.keymap.set("n", "<leader>k" , builtin.keymaps   , { desc = "Telescope keymaps"   })
vim.keymap.set("n", "<leader>so", builtin.oldfiles  , { desc = "Telescope oldfiles"  })
vim.keymap.set("n", "<leader>sh", builtin.help_tags , { desc = "Telescope help tags" })

require 'mini.pairs'.setup()
-- Autopair < > on supported filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "html", "javascriptreact", "typescriptreact", "jsx", "tsx" },
  group = vim.api.nvim_create_augroup("MiniPairsHtmlTags", { clear = true }), -- runs once per buffer)
  callback = function(opts)
    if require("mini.pairs") then
      local MiniPairs = require("mini.pairs")

      local pair_info = {
        action = "open",
        pair = "<>",
        action_close = "<BS>",
      }

      MiniPairs.map_buf(opts.buf, "i", "<", pair_info)
    end
  end,
})

require('oil').setup({
	default_file_explorer = true, -- Take over from netrw
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		['zh'] = 'actions.toggle_hidden',
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
