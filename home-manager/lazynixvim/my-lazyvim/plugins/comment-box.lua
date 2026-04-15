return {
  'LudoPinelli/comment-box.nvim',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_create_user_command('CommentBoxLeft', 'lua require("comment-box").lbox()', { force = true })
    vim.api.nvim_create_user_command('CommentBoxCenter', 'lua require("comment-box").cbox()', { force = true })
  end,
}
