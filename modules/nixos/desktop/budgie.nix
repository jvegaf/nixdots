{ pkgs, ... }:
{
  # imports = [
  #   ../../programs/thunar.nix
  # ];
  # services.xserver.libinput.enable = true;
  services.displayManager.defaultSession = "budgie-desktop";
  services.desktopManager.budgie.enable = true;

  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    adapta-backgrounds
    tela-icon-theme
    papirus-icon-theme
    ristretto
    parole
  ];

  environment.budgie.excludePackages = with pkgs; [
    mate-terminal
    nano
  ];

}
