{ pkgs, inputs, ... }:
{
  # repository avatars/wallpapers
  home.file."Pictures/nixconfig-avatars".source = ./avatars;
  home.file."Pictures/Wallpapers/nixconfig-wallpapers".source = ./wallpapers;

  programs.noctalia = {
    enable = true;
    settings = builtins.readFile ./config.toml;
    systemd.enable = true;
  };
}
