return {
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    -- optionally, override the default options:
    config = function()
      require('tailwindcss-colorizer-cmp').setup({
        color_square_width = 2,
      })
    end,
    event = 'InsertEnter',
    lazy = true,
  },
  {
    'MaximilianLloyd/tw-values.nvim',
    lazy = false,
    keys = {
      { '<leader>sv', '<cmd>TWValues<cr>', desc = 'Show tailwind CSS values' },
    },
    opts = {
      border = 'rounded', -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = true, -- Sets the preview as the current window
      copy_register = '', -- The register to copy values to,
      keymaps = {
        copy = '<C-y>', -- Normal mode keymap to copy the CSS values between {}
      },
    },
  },
}
