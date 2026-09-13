{ pkgs, ... }:
{
  # imports = [
  #   ../../programs/thunar.nix
  # ];

  # Enable Sway
  programs.sway.enable = true;


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
