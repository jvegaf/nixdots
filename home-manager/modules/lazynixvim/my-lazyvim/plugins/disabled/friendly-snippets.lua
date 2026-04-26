return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").load({ paths = { "./my_snippets" } })
    end,
    keys = {
      -- stylua: ignore
      {
        "<leader>sz",
        function() require("luasnip.loaders").edit_snippet_files() end,
        desc = "Edit snippets",
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "benfowler/telescope-luasnip.nvim",
      config = function()
        require("telescope").load_extension("luasnip")
      end,
    },
    keys = {
      -- stylua: ignore
      {
        "<leader>fs",
        function() require'telescope'.extensions.luasnip.luasnip{} end,
        desc = "Search snippets",
      },
    },
  },
}
