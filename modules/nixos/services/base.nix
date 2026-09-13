{pkgs, ...}: {
  security.polkit.enable = true;
  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus = {
      implementation = "broker";
      packages = with pkgs; [
        gnome-settings-daemon
        libsecret
      ];
    };
    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    power-profiles-daemon.enable = true;
    upower.enable = true;
    thermald.enable = true;
    # Trackpad and input device optimization - using updated option names
    libinput = {
      enable = true; # Previously services.xserver.libinput.enable
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
  };
}
