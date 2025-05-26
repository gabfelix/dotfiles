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
    -- { '<leader>os', '<cmd>OverseerRun<cr>', desc = 'Overseer Toggle VSplit' },
  },
}
