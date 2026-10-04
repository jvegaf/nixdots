{ inputs, lib, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  # repository avatars/wallpapers
  home.file."Pictures/nixdots-avatars".source = ./avatars;
  home.file."Pictures/Wallpapers/nixdots-wallpapers".source = ./wallpapers;

  programs.noctalia = {
    enable = true;
    settings = builtins.readFile ./config.toml;
  };
}
