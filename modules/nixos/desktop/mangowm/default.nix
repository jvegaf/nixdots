{ inputs, pkgs, ... }: {
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    # config = {
    #   sway = {
    #     default = [
    #       "gtk"
    #     ];
    #     "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    #   };
    # };
  };

  services.displayManager = {
    defaultSession = "mango"; # derived from mango.desktop filename
    autoLogin = {
      enable = true;
      user = "th3g3ntl3man";
    };
  };

  programs.mango.enable = true;
}
