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
      vim.binds.whichKey.enable = true;
    };
  };

}
