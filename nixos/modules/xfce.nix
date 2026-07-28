{ ... }:
{
  # services.xserver.libinput.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.defaultSession = "xfce";
  services.xserver.desktopManager.xfce.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.thunar.enable = true;
}
