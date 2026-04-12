{ config, lib, pkgs, ... }:

# AIDEV-NOTE: GTK theming configuration for Breeze Dark theme
{
  # GTK 2 settings (legacy)
  home.file.".gtkrc-2.0".text = ''
    gtk-enable-animations=1
    gtk-theme-name="Breeze-Dark"
    gtk-primary-button-warps-slider=1
    gtk-toolbar-style=3
    gtk-menu-images=1
    gtk-button-images=1
    gtk-cursor-blink-time=1000
    gtk-cursor-blink=1
    gtk-cursor-theme-size=24
    gtk-cursor-theme-name="capitaine-cursors"
    gtk-sound-theme-name="ocean"
    gtk-icon-theme-name="breeze-dark"
    gtk-font-name="Noto Sans,  10"
  '';

  # GTK 3 settings
  home.file.".config/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Breeze-Dark
      gtk-icon-theme-name=breeze-dark
      gtk-font-name=Noto Sans, 10
      gtk-cursor-theme-name=capitaine-cursors
      gtk-cursor-theme-size=24
      gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
      gtk-button-images=1
      gtk-menu-images=1
      gtk-enable-animations=1
    '';
  };

  # GTK 4 settings (via environment)
  home.sessionVariables = {
    # GTK Theme
    GTK_THEME = "Breeze-Dark:dark";

    # QT Theme compatibility
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # XDG for GTK apps
    XDG_CURRENT_DESKTOP = "KDE";
    XDG_SESSION_TYPE = "wayland";
  };

  # AIDEV-NOTE: Some GTK configs can also be managed via dconf/gsettings
  # Consider adding services.gnome.gsettings if needed
}
