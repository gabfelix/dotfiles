return {
  'echasnovski/mini-git',
  version = false,
  main = 'mini.git',
  cond = vim.fn.executable '/usr/bin/git',
  dependencies = {
    { 'echasnovski/mini.diff', version = false, opts = {} },
  },
  opts = {},
}
