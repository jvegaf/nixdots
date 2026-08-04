{ pkgs, inputs, ... }:
{
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        builtin = "Tokyo-Night";
        mode = "dark";
        source = "community";
        communityPalette = "Oxocarbon";
      };
      wallpaper = {
        enabled = true;
        default.path = "${../wallpapers/bg_2.jpg}";
      };
    };
  };
}
