{  pkgs, ... } :
{
   programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.theme = {
        enable = true;
	name = "onedark";
	style = "dark";
      };
      vim.languages.nix.enable = true;
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.autocomplete.blink-cmp.enable = true;
      vim.autopairs.nvim-autopairs.enable = true;
      vim.filetree.nvimTree.enable = true;
      vim.formatter.conform-nvim.enable = true;
      vim.binds.whichKey.enable = true;
        vim.lazy.plugins.vim-tmux-navigator = {
            package = pkgs.vimPlugins.vim-tmux-navigator;
            event = ["VimEnter"];
            keys = [
                    {
                        key = "<C-h>";
                        mode = [ "n" ];
                        action = "<CMD><C-U>TmuxNavigateLeft<CR>";
                        desc = "Focus Left";
                    }
                    {
                        key = "<C-l>";
                        mode = [ "n" ];
                        action = "<CMD><C-U>TmuxNavigateRight<CR>";
                        desc = "Focus Right";
                    }
                    {
                        key = "<C-j>";
                        mode = [ "n" ];
                        action = "<CMD><C-U>TmuxNavigateDown<CR>";
                        desc = "Focus Down";
                    }
                    {
                        key = "<C-k>";
                        mode = [ "n" ];
                        action = "<CMD><C-U>TmuxNavigateUp<CR>";
                        desc = "Focus Up";
                    }
            ];
          };
    };
  };

}
