-- stylua: ignore
return {
  'chrisgrieser/nvim-scissors',
  event = 'VeryLazy',
  dependencies = { 'folke/snacks.nvim' },
  opts = {},
  keys = {
    { '<leader>se', function() require('scissors').editSnippet() end, desc = 'Snippet: Edit' },
    { '<leader>sa', function() require('scissors').addNewSnippet() end, mode = {'n', 'x'}, desc = 'Snippet: Add' },
  },
}
