{ pkgs, inputs, ... }:
{
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      }; # configure options
    };
  };
}
