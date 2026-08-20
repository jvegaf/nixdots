{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
  cfg = osConfig.modules.display.desktop;

in
{
  imports = [
    ./dconf.nix
  ];

  config = mkIf cfg.gnome.enable {
    home.packages = with pkgs; [
      decibels
      parole
      gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.cpu-temp-hwmon
      gnomeExtensions.freon
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.gsconnect
      gnomeExtensions.tophat
      wl-clipboard
    ];

    # Set Microsoft Edge as default browser
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
    };

    # GTK theme settings
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
      };
      iconTheme = {
        name = "Adwaita";
      };
      cursorTheme = {
        name = "Adwaita";
        size = 24;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
