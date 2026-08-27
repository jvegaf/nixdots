{
  keymaps = [
    {
      mode = "n";
      key = "<leader>hx";
      action.__raw = ''
        function() require("harpoon.mark").add_file() end
      '';
      options.desc = "Harpoon Mark";
    }
    {
      mode = "n";
      key = "<leader>hn";
      action.__raw = ''
        function() require("harpoon.ui").nav_next() end
      '';
      options.desc = "Harpoon Next";
    }
    {
      mode = "n";
      key = "<leader>hp";
      action.__raw = ''
        function() require("harpoon.ui").nav_prev() end
      '';
      options.desc = "Harpoon Previous";
    }
    {
      mode = "n";
      key = "<leader>hl";
      action.__raw = ''
        function() require("harpoon.ui").toggle_quick_menu() end
      '';
      options.desc = "Harpoon List";
    }
  ];
  plugins = {
    telescope.enable = true;
    harpoon = {
      enable = true;
      enableTelescope = true;
    };
  };
}
