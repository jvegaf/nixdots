{ pkgs, ... }:
{
  # imports = [
  #   ../../programs/thunar.nix
  # ];
  # services.xserver.libinput.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.displayManager.defaultSession = "budgie-desktop";
  services.xserver.desktopManager.budgie.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.budgie.excludePackages = with pkgs; [
    mate.mate-terminal
    nano
  ];

}
