local VAULT_PATH = vim.fn.expand '~' .. '/doc/Thought Cabinet'

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    'BufReadPre ' .. VAULT_PATH .. '/*',
    'BufNewFile ' .. VAULT_PATH .. '/*',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'Thought Cabinet',
        path = VAULT_PATH,
      },
    },
  },
  config = function(opts)
    require('obsidian').setup(opts)
    vim.opt.conceallevel = 2
  end,
}
