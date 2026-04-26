return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>y',
        function()
          require('yazi').yazi()
        end,
        desc = 'Open the file manager',
      },
      {
        '<leader>cw',
        function()
          require('yazi').yazi(nil, vim.fn.getcwd())
        end,
        desc = 'Open yazi in working directory',
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}
