return {
  'MHD-GDev/genlms.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lualine/lualine.nvim',
  },
  config = function()
    require('genlms').setup({
      quit_map = 'q',
      retry_map = '<c-r>',
      accept_map = '<c-cr>',
      host = 'localhost',
      port = '1234',
      display_mode = 'split',
      show_prompt = true,
      show_model = true,
      no_auto_close = false,
      json_response = true,
      result_filetype = 'markdown',
      debug = false,
    })

    -- Key mappings (Change as you like)
    vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Genlms<CR>')
    vim.keymap.set('n', '<leader>aa', '<CMD>Genlms Ask<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>ac', '<CMD>Genlms Chat<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>ag', '<CMD>Genlms Generate<CR>', { noremap = true })
    vim.keymap.set('v', '<leader>aD', ":'<,'>Genlms Document_Code<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>aC', ":'<,'>Genlms Change<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>ae', ":'<,'>Genlms Enhance_Code<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>aR', ":'<,'>Genlms Review_Code<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>as', ":'<,'>Genlms Summarize<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>aa', ":'<,'>Genlms Ask<CR>", { noremap = true })
    vim.keymap.set('v', '<leader>ax', ":'<,'>Genlms Fix_Code<CR>", { noremap = true })
    vim.keymap.set('n', '<leader>al', '<CMD>GenLoadModel<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>au', '<CMD>GenUnloadModel<CR>', { noremap = true })
  end,
}
