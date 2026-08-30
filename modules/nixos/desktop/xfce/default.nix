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
        enableScreensaver = false;
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

  security.pam.services.gdm.enableGnomeKeyring = true;
  # programs.xfconf.enable = true;
  programs.dconf.enable = true;

  environment = {
    sessionVariables.ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
    pathsToLink = [ "/share/backgrounds" ];
    xfce.excludePackages = with pkgs; [
      gnome-themes-extra
      parole
      pavucontrol
      ristretto
      xfce4-notifyd
      xfce4-screensaver
      xfce4-screenshooter
      xfce4-terminal
      xfce4-volumed-pulse
    ];
    systemPackages = with pkgs; [
      adapta-backgrounds
      adapta-gtk-theme
      blueman
      catfish
      deja-dup
      elementary-xfce-icon-theme
      epiphany
      file-roller
      gigolo
      papirus-icon-theme
      parole
      ristretto
      tela-icon-theme
      thunar-shares-plugin
      whitesur-cursors
      whitesur-gtk-theme
      whitesur-icon-theme
      xarchiver
      xclip
      xfce4-appfinder
      xfce4-clipman-plugin
      xfce4-cpufreq-plugin
      xfce4-cpugraph-plugin
      xfce4-fsguard-plugin
      xfce4-genmon-plugin
      xfce4-icon-theme
      xfce4-netload-plugin
      xfce4-panel
      xfce4-panel-profiles
      xfce4-sensors-plugin
      xfce4-session
      xfce4-systemload-plugin
      xfce4-taskmanager
      xfce4-whiskermenu-plugin
      xfce4-xkb-plugin
      xfdashboard
      xsel
    ];
  };

}
