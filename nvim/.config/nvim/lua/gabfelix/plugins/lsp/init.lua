return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		config = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				cmd = {'LspInfo', 'LspInstall', 'LspStart'},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = "mason.nvim",
			},
			{ "nvim-cmp" }
		},
		config = function(_, opts)
			local lsp_zero = require('lsp-zero')
			local packages = {
				'pyright',
				'rust_analyzer',
				'tsserver',
				'eslint',
			}

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
			end)

			require('mason-lspconfig').setup({
				ensure_installed = packages,
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end
	},
	{
		"williamboman/mason.nvim",
		config = true
	},
	{
		"hrsh7th/nvim-cmp",
		event = 'LspAttach',
		dependencies = {
		  'L3MON4D3/LuaSnip',
		  'saadparwaiz1/cmp_luasnip',

		  'hrsh7th/cmp-nvim-lsp',
		  -- 'rafamadriz/friendly-snippets',
		}
	}
}
