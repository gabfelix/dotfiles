return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	config = false,
	-- event = 'BufEnter *.py, *.rs', -- This works, but the LSP will not be autostarted
	lazy = false,
	dependencies = {
		{ "neovim/nvim-lspconfig",
			cmd = {'LspInfo', 'LspInstall', 'LspStart'},
		},
		{ "williamboman/mason-lspconfig.nvim",
			dependencies = {
				{ "williamboman/mason.nvim",
				lazy = false, -- Mason documentation does not recommend lazy-loading the plugin
				config = true
				},
			},
		},
		{ "hrsh7th/nvim-cmp",
			event = 'InsertEnter',
			dependencies = {
			  'L3MON4D3/LuaSnip',
			  'saadparwaiz1/cmp_luasnip',

			  'hrsh7th/cmp-nvim-lsp',
			  -- 'rafamadriz/friendly-snippets',
			}
		}
	},
	config = function(_, opts)
		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({buffer = bufnr})
		end)

		require('mason-lspconfig').setup({
			ensure_installed = {'pyright', 'rust_analyzer'},
			handlers = {
				lsp_zero.default_setup,
			},
		})
	end
}
