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
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      --   require("NeoSolarized").setup({
      --     theme = "light", -- dark or light
      --   })
      -- vim.cmd([[ colorscheme oxocarbon ]])
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    priority = 1000,
    lazy = false,
    -- config = function()
    --   require("modus-themes").setup({})
    --   -- vim.cmd("colorscheme modus")
    -- end,
  },
  {
    'oxfist/night-owl.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   require("night-owl").setup({})
    --   -- vim.cmd([[ colorscheme night-owl ]])
    -- end,
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
    'eldritch-theme/eldritch.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      variant = 'moon',
      -- disable_background = is_transparent,
      -- disable_float_background = is_transparent,
      styles = {
        bold = true,
        italic = true,
        -- transparency = is_transparent,
      },
    },
    lazy = false,
    priority = 1000,
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
