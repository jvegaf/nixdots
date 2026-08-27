{ pkgs, ... }:
{
  imports = [
    ../../programs/thunar.nix
  ];
  # services.xserver.libinput.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        # noDesktop = true;
        enableXfwm = true;
      };
    };
    # windowManager.i3.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs.xfconf.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.defaultSession = "xfce";

  environment.systemPackages = with pkgs; [
    xsel
    xclip
    xfce4-cpugraph-plugin
    xfce4-cpufreq-plugin
    xfce4-sensors-plugin
    elementary-xfce-icon-theme
    xfce4-icon-theme
    adapta-gtk-theme
    adapta-backgrounds
    whitesur-gtk-theme
    whitesur-cursors
    whitesur-icon-theme
    tela-icon-theme
    papirus-icon-theme
    ristretto
    parole
    blueman
    file-roller

  ];

}
