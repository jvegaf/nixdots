{
  flake.nixosModules.thunar = {pkgs, ...}: {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        xfce.thunar-archive-plugin
        xfce.thunar-volman
      ];
    };

    services.udisks2.enable = true;
    security.polkit.enable = true;
  };
}
