_: {
  plugins.nvim-tree = {
    enable = true;
    autoClose = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>NvimTreeFocus<cr>";
      options = {
        desc = "Open NvimTree";
      };
    }
  ];
}
