{ pkgs, ... }:

# AIDEV-NOTE: Qt theming configuration with qt5ct/qt6ct support
{
  home.packages = with pkgs; [
    papirus-icon-theme
    pcmanfm-qt
    libsForQt5.qt5ct
    libsForQt5.kde5 qt6ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style = {
      package = pkgs.libsForQt5.breeze-qt5;
      name = "Breeze-Dark";
    };
  };

  # Environment variables for Qt apps
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # Qt5ct configuration files
  home.file.".config/qt5ct/qt5ct.conf" = {
    text = ''
      [Appearance]
      standard_dialogs=default
      color_scheme_path=/usr/share/qt5ct/colors/darker.conf
      custom_palette=false
      icon_theme=breeze-dark
      schemes=darker

      [Fonts]
      fixed=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\x10\0\xd\xa)
      general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\x10\0\xd\xa)
    '';
  };

  home.file.".config/qt6ct/qt6ct.conf" = {
    text = ''
      [Appearance]
      standard_dialogs=default
      color_scheme_path=/usr/share/qt6ct/colors/darker.conf
      custom_palette=false
      icon_theme=breeze-dark
      schemes=darker

      [Fonts]
      fixed=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\x10\0\xd\xa)
      general=@Variant(\0\0\0@\0\0\0\x12\0N\0o\0t\0o\0 \0S\0\x61\0n\0s@$\0\x10\0\xd\xa)
    '';
  };

  # Kvantum theme configuration
  home.file.".config/Kvantum/kvantum.kvconfig" = {
    text = ''
      [General]
      theme=BreezeDark

      [InterfaceColors]
      button[active]=@Variant(\0\0\0@\0\0\0\x1\0\xff\xff)
      button[hover]=@Variant(\0\0\0@\0\0\0\x1\0\xff\xff)
    '';
  };
}
