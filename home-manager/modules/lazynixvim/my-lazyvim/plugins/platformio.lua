return {
  {
    'anurag3301/nvim-platformio.lua',
    -- enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'akinsho/toggleterm.nvim',
    },
    config = function()
      require('platformio').setup({})

      vim.api.nvim_create_user_command('PioInit', "TermExec cmd='pio project init'", {})
      vim.api.nvim_create_user_command('PioBuild', "TermExec cmd='pio run'", {})
      vim.api.nvim_create_user_command('PioUpload', "TermExec cmd='pio run -t upload'", {})
      vim.api.nvim_create_user_command('PioUploadMonitor', "TermExec cmd='pio run -t upload -t monitor'", {})
      vim.api.nvim_create_user_command('PioMonitor', "TermExec cmd='pio device monitor'", {})
      vim.api.nvim_create_user_command('PioLsp', "TermExec cmd='pio run -t compiledb'", {})
      vim.api.nvim_create_user_command('PioClean', "TermExec cmd='pio run -t clean'", {})
      vim.api.nvim_create_user_command('PioUpdate', "TermExec cmd='pio pkg update'", {})

      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<leader>pb', ':PioBuild<CR>', { desc = 'PlatformIO Build', unpack(opts) })
      vim.keymap.set('n', '<leader>pu', ':PioUpload<CR>', { desc = 'PlatformIO Upload', unpack(opts) })
      vim.keymap.set('n', '<leader>pa', ':PioUploadMonitor<CR>', { desc = 'PlatformIO Upload & Monitor', unpack(opts) })
      vim.keymap.set('n', '<leader>pm', ':PioMonitor<CR>', { desc = 'PlatformIO Monitor', unpack(opts) })

      vim.keymap.set('n', '<leader>pi', ':PioInit<CR>', { desc = 'PlatformIO Init', unpack(opts) })
      vim.keymap.set('n', '<leader>pl', ':PioLsp<CR>', { desc = 'PlatformIO Update LSP (Fix Red Lines)', unpack(opts) })
      vim.keymap.set('n', '<leader>pc', ':PioClean<CR>', { desc = 'PlatformIO Clean Project', unpack(opts) })
    end,
  },
}
