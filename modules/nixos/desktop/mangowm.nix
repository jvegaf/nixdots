{ inputs, pkgs, ... }: {
  imports = [
    inputs.mangowm.nixosModules.mango
  ];


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };


  programs.mango.enable = true;
}
