{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;

      font = {
        builtin_box_drawing = true;
        size = 14;
        normal = {
          style = lib.mkForce "Bold";
          family = "Fantasque SansM Nerd Font";
        };
      };
    };
  };
}
