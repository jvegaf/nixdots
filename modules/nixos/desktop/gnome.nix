{ pkgs, ... }:
{
  services = {
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    baobab
    decibels
    gnome-characters
    gnome-connections
    gnome-contacts
    gnome-maps
    gnome-tour
    gnome-terminal
    gnome-software
    seahorse
    showtime
    snapshot
    yelp
  ];
}
