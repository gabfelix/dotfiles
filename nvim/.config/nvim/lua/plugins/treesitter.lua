return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'toml',
      'yaml',
      'ini',
      'rust',
      'javascript',
      'typescript',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 50000
      end,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = false },
  },
}
