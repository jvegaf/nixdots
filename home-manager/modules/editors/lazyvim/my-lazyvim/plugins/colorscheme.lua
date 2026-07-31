return {
  {
    'AstroNvim/astrotheme',
    lazy = false,
    priority = 1000,
    config = function()
      require('astrotheme').setup({
        -- style = {
        --   transparent = true,
        -- },
      })
    end,
  },
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'deep',
        transparent = true,
      })
      -- require('onedark').load()
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("catppuccin").setup({
    --     flavor = "mocha",
    --     transparent_background = is_transparent,
    --   })
    --   -- vim.cmd("colorscheme catppuccin")
    -- end,
  },
  {
    'polirritmico/monokai-nightasty.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    opts = {
      style = 'night',
      -- transparent = true,
      -- styles = {
      --   sidebars = 'transparent',
      --   floats = 'transparent',
      -- },
    },
  },
  {
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    config = function()
      require('ayu').setup({
        mirage = false,
        -- overrides = {
        --   Normal = { bg = 'None' },
        --   NormalFloat = { bg = 'none' },
        --   ColorColumn = { bg = 'None' },
        --   SignColumn = { bg = 'None' },
        --   Folded = { bg = 'None' },
        --   FoldColumn = { bg = 'None' },
        --   CursorLine = { bg = 'None' },
        --   CursorColumn = { bg = 'None' },
        --   VertSplit = { bg = 'None' },
        -- },
      })
      vim.o.background = 'dark'
      -- require('ayu').colorscheme()
      -- vim.cmd('colorscheme ayu')
    end,
  },
}
