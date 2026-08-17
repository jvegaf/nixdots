{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      vlc
      gnome-disk-utility
      qbittorrent
      wlr-randr
      wl-clipboard
      lxappearance
    ];
  };
}
