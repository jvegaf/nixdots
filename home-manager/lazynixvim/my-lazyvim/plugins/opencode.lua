-- stylua: ignore
return {
  'NickvanDyke/opencode.nvim',
  enabled = false,
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    { '<leader>oo', function() require('opencode').toggle() end, mode = { 'n' }, desc = 'Toggle OpenCode' },
    { '<leader>os', function() require('opencode').select({ submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode select' },
    { '<leader>oi', function() require('opencode').ask('', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode ask' },
    { '<leader>oI', function() require('opencode').ask('@this: ', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode ask with context' },
    { '<leader>ob', function() require('opencode').ask('@file ', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode ask about buffer' },
    { '<leader>op', function() require('opencode').prompt('@this', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode prompt' },
    { 'go', function() return require('opencode').operator('@this ') end, mode = { 'n', 'x' }, desc = 'Add range to opencode', expr = true },
    { 'goo', function() return require('opencode').operator('@this ') .. '_' end, mode = { 'n' }, desc = 'Add line to opencode', expr = true },

    { '<S-C-u>', function() require('opencode').command('session.half.page.up') end, mode = { 'n' }, desc = 'Scroll opencode up' },
    { '<S-C-d>', function() require('opencode').command('session.half.page.down') end, mode = { 'n' }, desc = 'Scroll opencode down' },

    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
    { '+', '<C-a>', mode = { 'n' }, desc = 'Increment under cursor', noremap = true },
    { '-', '<C-x>', mode = { 'n' }, desc = 'Decrement under cursor', noremap = true },

    -- Built-in prompts
    { '<leader>ope', function() require('opencode').prompt('explain', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode explain' },
    { '<leader>opf', function() require('opencode').prompt('fix', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode fix' },
    { '<leader>opd', function() require('opencode').prompt('diagnose', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode diagnose' },
    { '<leader>opr', function() require('opencode').prompt('review', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode review' },
    { '<leader>opt', function() require('opencode').prompt('test', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode test' },
    { '<leader>opo', function() require('opencode').prompt('optimize', { submit = true }) end, mode = { 'n', 'x' }, desc = 'OpenCode optimize' },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = {
        snacks = {
          win = {
            position = 'right',
          },
        },
      },
    }
    vim.o.autoread = true
  end,
}
