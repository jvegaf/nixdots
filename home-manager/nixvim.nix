{lib, ...}: {
  enable = true;
  defaultEditor = true;
  # You can use lib.nixvim in your config
  fooOption = lib.nixvim.mkRaw "print('hello')";

  # Configure Nixvim without prefixing with `plugins.nixvim`
  # plugins.my-plugin.enable = true;
  clipboard.register = "unnamedplus";
  keymaps = [
    {
      key = "W";
      mode = ["n"];
      action = "<CMD>write<CR>";
    }
    {
      key = "Q";
      mode = ["n"];
      action = "<CMD>bdelete<CR>";
    }
  ];
}
