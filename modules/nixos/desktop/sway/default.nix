{ pkgs, ... }:
{
  # imports = [
  #   ../../programs/thunar.nix
  # ];

  security.polkit.enable = true;
  # Enable the X11/Wayland base support if needed
  services.xserver.enable = true;

  # Enable Sway
  programs.sway.enable = true;

  # Enable SDDM and its Wayland capabilities
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # optional, runs SDDM under Wayland if supported
  };

  # Set Sway as the default pre-selected or auto-login session
  services.displayManager.defaultSession = "sway";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config = {
      sway = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
    };
  };
}
