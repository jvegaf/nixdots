return {
  'supermaven-inc/supermaven-nvim',
  enabled = false,
  event = 'VeryLazy',
  config = function()
    require('supermaven-nvim').setup({
      keymaps = {
        accept_suggestion = '<M-f>',
        clear_suggestion = '<C-]>',
        accept_word = '<M-w>',
      },
    })
  end,
}
