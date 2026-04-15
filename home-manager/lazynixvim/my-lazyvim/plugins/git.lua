return {
  {
    'dinhhuy258/git.nvim',
    event = 'BufReadPre',
    opts = {
      keymaps = {
        -- Open blame window
        blame = '<Leader>gB',
        -- Open file/folder in git repository
        browse = '<Leader>go',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    event = 'BufReadPre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<localleader>gs', '<cmd>Gitsigns stage_buffer<cr>', desc = 'Stage buffer' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_buffer<cr>', desc = 'Undo stage buffer' },
      { '<localleader>gr', '<cmd>Gitsigns reset_buffer<cr>', desc = 'Reset buffer' },
      { '<localleader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
      { '<localleader>gb', '<cmd>Gitsigns blame_line<cr>', desc = 'Blame line' },
      { '<localleader>gn', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
      { '<localleader>gp', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },
      { '<localleader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk' },
      { '<localleader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo stage hunk' },
      { '<localleader>gv', '<cmd>Gitsigns select_hunk<cr>', desc = 'Select hunk' },
      { '<localleader>gl', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Toggle current line blame' },
      { '<localleader>gs', '<cmd>Gitsigns toggle_signs<cr>', desc = 'Toggle signs' },
      { '<localleader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
      { '<localleader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk' },
      { '<localleader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo stage hunk' },
      { '<localleader>gv', '<cmd>Gitsigns select_hunk<cr>', desc = 'Select hunk' },
      { '<localleader>gl', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Toggle current line blame' },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close diff' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'View file history' },
      { '<leader>gf', ":'<,'>DiffviewFileHistory<cr>", mode = { 'v' }, desc = 'View selected history' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup({
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        },
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
          vim.keymap.set('n', 'cww', function()
            engage.conflict_buster()
            create_buffer_local_mappings()
          end)
        end,
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'paopaol/telescope-git-diffs.nvim',
    },
    config = function()
      require('telescope').load_extension('git_diffs')
    end,
    keys = {
      { '<leader>gz', '<cmd>Telescope git_diffs  diff_commits<CR>', desc = 'Telescope diff_commits' },
      { '<leader>gb', '<cmd>Telescope git_branches <CR>', desc = 'Branches' },
    },
  },
}
