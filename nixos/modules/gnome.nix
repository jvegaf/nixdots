{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

    # Keyboard layout
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Touchpad support
    services.libinput.enable = true;

    # GNOME-specific packages
    environment.systemPackages = with pkgs; [
      ghostty
    ];
}
