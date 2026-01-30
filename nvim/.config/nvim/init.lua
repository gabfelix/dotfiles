local path_package = vim.fn.stdpath 'data' .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

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
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 8
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.hlsearch = true

vim.keymap.set('n', '<F7>', function()
  vim.cmd('edit ' .. vim.fn.stdpath 'config' .. '/init.lua')
end)

if vim.g.neovide and vim.fn.has 'win32' and vim.fn.argc() == 0 then
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function()
      vim.api.nvim_set_current_dir(vim.fn.expand '~')
    end,
  })
  pcall(function()
    vim.o.guifont = 'Consolas:h11'
  end)
end

local MiniDeps = require 'mini.deps'
local MiniCompletion = require 'mini.completion'

MiniDeps.setup { path = { package = vim.fn.stdpath 'data' .. 'site/pack/deps' } }

local add = MiniDeps.add
local later = MiniDeps.later
local now = MiniDeps.now
local now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup {
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  }

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  later(require('mini.icons').mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(require('mini.icons').tweak_lsp_kind)
end)

add 'nvim-mini/mini.surround'
-- make mini.surround work like tpope/vim-surround
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
    update_n_lines = '',
  },
  search_method = 'cover_or_next',
}
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true }) -- surround selection
vim.keymap.set('n', 'yss', 'ys_', { noremap = false }) -- surround line

require('mini.pairs').setup()
-- Autopair < > on Javaslop
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('MiniPairsHtmlTags', { clear = true }),
  pattern = { 'html', 'xml', 'javascriptreact', 'typescriptreact' },
  callback = function(opts)
    require('mini.pairs').map_buf(opts.buf, 'i', '<', {
      action = 'open',
      pair = '<>',
      neigh_pattern = '\r.', -- only open pair in line start (\r)
    })
    require('mini.pairs').map_buf(opts.buf, 'i', '>', {
      action = 'close',
      pair = '<>',
    })
  end,
})

later(function()
  require('mini.extra').setup()
  require('mini.pick').setup()
  vim.keymap.set('n', '<leader>sf', '<cmd>Pick files<cr>')
  vim.keymap.set('n', '<leader>sg', '<cmd>Pick grep_live<cr>')
  vim.keymap.set('n', '<leader>sd', '<cmd>Pick diagnostic scope="current"<cr>')
  vim.keymap.set('n', '<leader>sD', '<cmd>Pick diagnostic scope="all"<cr>')
  vim.keymap.set('n', '<leader>ds', '<cmd>Pick lsp scope="workspace_symbol_live"<cr>')
  vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<cr>')
end)

later(function()
  add 'stevearc/oil.nvim'
  require('oil').setup {
    default_file_explorer = true, -- Take over from netrw
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['zh'] = 'actions.toggle_hidden',
    },
  }
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
end)

-- TREESITTER
now_if_args(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    -- Update tree-sitter parser after plugin is updated
    hooks = {
      post_checkout = function()
        vim.cmd 'TSUpdate'
      end,
    },
  }
  require('nvim-treesitter').setup()
  -- Define languages which will have parsers installed and auto enabled
  local filetypes = {
    -- These are already pre-installed with Neovim. Used as an example.
    'lua',
    'vimdoc',
    'markdown',
    'c',
    'cpp',
    'python',
    'javascript',
    'typescript',
    'json',
    'gdscript',
    -- Add here more languages with which you want to use tree-sitter
    -- To see available languages:
    -- - Execute `:=require('nvim-treesitter').get_available()`
    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
  }
  -- require('nvim-treesitter').install(filetypes) -- TODO: for some reason, install() recompiles the parsers on every launch, hopefully this fixes it
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function()
      vim.treesitter.start()
    end,
  })
end)

-- LSP
later(function()
  add 'mason-org/mason.nvim'
  require('mason').setup()
end)

later(function()
  add 'neovim/nvim-lspconfig'
  vim.lsp.enable { 'lua_ls', 'clangd' }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
end)

-- Formatting
later(function()
  add 'stevearc/conform.nvim'
  require('conform').setup {
    default_format_opts = {
      lsp_format = 'fallback', -- fallback to LSP if no dedicated formatter is installed
    },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  }
  vim.keymap.set('n', '<leader>f', '<cmd>lua require("conform").format()<cr>')
  vim.keymap.set('x', '<leader>f', '<cmd>lua require("conform").format()<cr>')
end)

later(function()
  -- Customize post-processing of LSP responses for a better user experience.
  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup {
    lsp_completion = {
      -- Without this config autocompletion is set up through `:h 'completefunc'`.
      -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
      -- (sets up only when needed) and makes it possible to use `<C-u>`.
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  }

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = on_attach,
    desc = "Set 'omnifunc'",
  })
  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
  require('mini.snippets').start_lsp_server()
end)

later(function()
  -- Define language patterns to work better with 'friendly-snippets'
  local latex_patterns = { 'latex/**/*.json', '**/latex.json' }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    -- Recognize special injected language of markdown tree-sitter parser
    markdown_inline = { 'markdown.json' },
  }

  local snippets = require 'mini.snippets'
  local config_path = vim.fn.stdpath 'config'
  snippets.setup {
    snippets = {
      -- Always load 'snippets/global.json' from config directory
      snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
      -- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
      snippets.gen_loader.from_lang { lang_patterns = lang_patterns },
    },
  }

  -- By default snippets available at cursor are not shown as candidates in
  -- 'mini.completion' menu. This requires a dedicated in-process LSP server
  -- that will provide them. To have that, uncomment next line (use `gcc`).
  require('mini.snippets').start_lsp_server()
end)

later(function()
  add 'rafamadriz/friendly-snippets'
end)

now(function()
  require('mini.statusline').setup {
    use_icons = true,
  }
end)

now(function()
  add 'ellisonleao/gruvbox.nvim'
  vim.opt.background = 'dark'
  vim.opt.cursorline = true
  vim.cmd.colorscheme 'gruvbox'
end)

