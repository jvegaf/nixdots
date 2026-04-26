return {
  'kevinhwang91/nvim-hlslens',
  event = 'VeryLazy',
  config = function()
    require('hlslens').setup({
      -- set to false to disable the default highlight group
      -- default = true,
      -- the name of highlight group
      -- default = "HlSearchLens",
      -- whether to link to the default highlight group
      -- default = false,
      -- whether to only enable hlslens for the current buffer
      current_only = false,
      -- whether to delete the default highlight group
      delete_hl = false,
      -- whether to enabled hlslens for treesitter
      enable_treesitter = true,
      -- whether to enabled hlslens for built-in lsp
      enable_lsp = true,
      -- whether to enabled hlslens for langserver
      enable_lang = true,
      -- whether to enabled hlslens for copilot
      enable_copilot = true,
    })
    local kopts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap(
      'n',
      'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts
    )
    vim.api.nvim_set_keymap(
      'n',
      'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts
    )
  end,
}
