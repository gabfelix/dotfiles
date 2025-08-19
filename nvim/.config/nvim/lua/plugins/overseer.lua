return {
  'stevearc/overseer.nvim',
  opts = {
    templates = {
      'builtin',
      'user.run_script',
    },
    task_list = {
      bindings = {
        ['<Esc>'] = 'Close',
        ['q'] = 'Close',
      },
    },
    task_launcher = {
      bindings = {
        n = {
          ['<Esc>'] = 'Cancel',
        },
      },
    },
    task_editor = {
      bindings = {
        n = {
          ['<Esc>'] = 'Cancel',
        },
      },
    },
  },
  config = true,
  keys = {
    { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
    { '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
    { '<leader>oa', '<cmd>OverseerQuickAction<cr>', desc = 'Perform Overseer Action on a Task' },
  },
}
