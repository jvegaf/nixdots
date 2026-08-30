{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    libinput.enable = true;
  };

  # GNOME-specific packages
  environment.systemPackages = with pkgs; [
    ghostty
    wl-clipboard
  ];

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
