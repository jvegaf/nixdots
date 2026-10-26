{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.7;

      font = {
        builtin_box_drawing = true;
        size = 13;
        normal = {
          style = lib.mkForce "Bold";
          # family = "Fantasque SansM Nerd Font";
          family = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}
