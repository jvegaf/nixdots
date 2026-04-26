return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     capabilities = {
  --       textDocument = {
  --         foldingRange = {
  --           dynamicRegistration = false,
  --           lineFoldingOnly = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { text = { '%s' }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        },
      })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = {
      'kevinhwang91/promise-async',
      'luukvbaal/statuscol.nvim',
    },
    opts = {},
    init = function()
      vim.keymap.set('n', 'zz', function()
        require('ufo').openAllFolds()
      end)
      vim.keymap.set('n', 'zM', function()
        require('ufo').closeAllFolds()
      end)
    end,
  },
}
