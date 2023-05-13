-- Bootstrap the package manager
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'ellisonleao/gruvbox.nvim'
	use 'navarasu/onedark.nvim'
	use { 'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use { 'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate',
		requires = { 'nvim-treesitter/playground', opt = true }
	}
	use { 'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
	use { 'hrsh7th/nvim-cmp',
		requires = { 
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		}
	}
end)
