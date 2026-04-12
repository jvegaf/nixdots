# AwesomeWM configuration for X11
{ config, lib, pkgs, ... }:

{
  # Enable X11
  services.xserver = {
    enable = true;
    layout = "es";
    xkbVariant = "";
  };

  # Enable AwesomeWM
  services.awesome = {
    enable = true;
    package = pkgs.awesome;
  };

  # Use lightdm as display manager
  services.displayManager = {
    lightdm = {
      enable = true;
      # greeter = pkgs.lightdm-gtk-greeter;
    };
    defaultSession = "awesome";
  };

  # Optional: install some X11 utilities
  environment.systemPackages = with pkgs; [
    xorg.xrandr
    xorg.xsetroot
    xorg.xev
    xorg.xprop
  ];
}
