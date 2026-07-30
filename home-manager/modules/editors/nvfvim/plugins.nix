{
  inputs,
  pkgs,
  ...
}:
{
  programs.nvf.settings.vim = {
    # Keep semantic navigation close to Neovim's modern defaults. These are
    # buffer-local and appear only when an LSP attaches.

    extraPlugins = with pkgs.vimPlugins; {
      url-open = {
        package = url-open;
        setup = "require('url-open').setup {}";
      };

      # harpoon = {
      #   package = harpoon;
      #   setup = "require('harpoon').setup {}";
      #   after = [ "aerial" ]; # place harpoon configuration after aerial
      # };
    };

    keymaps = [
      {
        mode = "n";
        key = "gx";
        action = "<cmd>lua require('url-open')<CR>";
        desc = "Open URL under cursor";
      }

    ];

    # keymaps = [
    #   {
    #     mode = "n";
    #     key = "<leader>xx";
    #     action = ''
    #       function()
    #         local trouble = require("trouble")
    #         trouble.close("buffer_diagnostics")
    #         trouble.close("lsp_references")
    #         local view = trouble.open("diagnostics")
    #         if view then
    #           view:action("first")
    #         end
    #       end
    #     '';
    #     lua = true;
    #     desc = "Open or focus all problems";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>xb";
    #     action = ''
    #       function()
    #         local trouble = require("trouble")
    #         trouble.close("diagnostics")
    #         trouble.close("lsp_references")
    #         local view = trouble.open("buffer_diagnostics")
    #         if view then
    #           view:action("first")
    #         end
    #       end
    #     '';
    #     lua = true;
    #     desc = "Open or focus current-file problems";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>xr";
    #     action = ''
    #       function()
    #         local trouble = require("trouble")
    #         trouble.close("diagnostics")
    #         trouble.close("buffer_diagnostics")
    #         local view = trouble.open("lsp_references")
    #         if view then
    #           view:action("first")
    #         end
    #       end
    #     '';
    #     lua = true;
    #     desc = "Open or focus symbol usages";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>oo";
    #     action = "<cmd>AerialOpen<CR>";
    #     desc = "Open or focus code outline";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>ob";
    #     action = "<cmd>lua require('dropbar.api').pick()<CR>";
    #     desc = "Pick breadcrumb";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>jt";
    #     action = "<cmd>lua require('treesitter-context').toggle()<CR>";
    #     desc = "Toggle syntax context";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>xd";
    #     action = "<cmd>lua vim.diagnostic.open_float()<CR>";
    #     desc = "Line diagnostic";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>xj";
    #     action = "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>";
    #     desc = "Next diagnostic (down)";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>xk";
    #     action = "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>";
    #     desc = "Previous diagnostic (up)";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>li";
    #     action = "<cmd>LspInfo<CR>";
    #     desc = "LSP information";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>lv";
    #     action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })<CR>";
    #     desc = "Toggle inlay hints";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>ld";
    #     action = "<cmd>lua require('gdscript-extended-lsp').pick()<CR>";
    #     desc = "Find Godot documentation";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "af";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Around function";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "if";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Inside function";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "ac";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Around class";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "ic";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Inside class";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "aa";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Around parameter";
    #   }
    #   {
    #     mode = [
    #       "x"
    #       "o"
    #     ];
    #     key = "ia";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Inside parameter";
    #   }
    #   {
    #     mode = [
    #       "n"
    #       "x"
    #       "o"
    #     ];
    #     key = "<leader>jfj";
    #     action = ''
    #       function()
    #         LuixTreesitterMove.next("@function.outer")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Next function (down)";
    #   }
    #   {
    #     mode = [
    #       "n"
    #       "x"
    #       "o"
    #     ];
    #     key = "<leader>jfk";
    #     action = ''
    #       function()
    #         LuixTreesitterMove.previous("@function.outer")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Previous function (up)";
    #   }
    #   {
    #     mode = [
    #       "n"
    #       "x"
    #       "o"
    #     ];
    #     key = "<leader>jcj";
    #     action = ''
    #       function()
    #         LuixTreesitterMove.next("@class.outer")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Next class (down)";
    #   }
    #   {
    #     mode = [
    #       "n"
    #       "x"
    #       "o"
    #     ];
    #     key = "<leader>jck";
    #     action = ''
    #       function()
    #         LuixTreesitterMove.previous("@class.outer")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Previous class (up)";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>jsl";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Swap parameter right";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>jsh";
    #     action = ''
    #       function()
    #         require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
    #       end
    #     '';
    #     lua = true;
    #     desc = "Swap parameter left";
    #   }
    # ];
  };
}
