{
  qt.enable = false;

  xfconf.settings = {
    xsettings = {
      "Gtk/CursorThemeName" = "WhiteSur-cursors";
      "Gtk/DecorationLayout" = "close,minimize,maximize:";
      "Net/IconThemeName" = "elementary-xfce-dark";
      "Net/ThemeName" = "WhiteSur-Dark-solid";
      "Gtk/FontName" = "Noto Sans SemiBold 11";
      "Gtk/MonospaceFontName" = "JetBrains Mono Medium 12";
    };

    xfce4-panel = {
      "configver" = 2;
      "panels" = [ 1 ];
      "panels/dark-mode" = true;

      "panels/panel-1/position" = "p=6;x=0;y=0";
      "panels/panel-1/length" = 100;
      "panels/panel-1/position-locked" = true;
      "panels/panel-1/icon-size" = 16;
      "panels/panel-1/size" = 26;
      "panels/panel-1/plugin-ids" = [
        3
        5
        6
        7
        8
        9
      ];

      "plugins/plugin-1" = "whiskermenu";
      "plugins/plugin-1/button-icon" = "distributor-logo-nixos";
      "plugins/plugin-1/category-show-name" = true;
      "plugins/plugin-1/default-category" = 1;
      "plugins/plugin-1/launcher-icon-size" = 2;
      "plugins/plugin-1/launcher-show-description" = false;
      "plugins/plugin-1/launcher-show-name" = false;
      "plugins/plugin-1/launcher-show-tooltip" = true;
      "plugins/plugin-1/position-categories-alternate" = true;
      "plugins/plugin-1/position-categories-horizontal" = false;
      "plugins/plugin-1/position-profile-alternate" = false;
      "plugins/plugin-1/position-search-alternate" = false;
      "plugins/plugin-1/recent" = [
        "kitty.desktop"
        "xfce-settings-manager.desktop"
        "xfce4-file-manager.desktop"
      ];
      "plugins/plugin-1/view-mode" = 1;

      "plugins/plugin-2" = "launcher";
      "plugins/plugin-2/grouping" = 1;
      "plugins/plugin-2/items" = [ "17879265501.desktop" ];

      "plugins/plugin-3" = "separator";
      "plugins/plugin-3/expand" = true;
      "plugins/plugin-3/style" = 0;

      "plugins/plugin-4" = "pager";
      "plugins/plugin-4/rows" = 1;
      "plugins/plugin-4/miniature-view" = false;

      "plugins/plugin-5" = "separator";
      "plugins/plugin-5/style" = 0;

      "plugins/plugin-6" = "systray";
      "plugins/plugin-6/square-icons" = true;
      "plugins/plugin-6/known-legacy-items" = [
        "ibus panel"
        "wi-fi network connection “fs0ciety” active: fs0ciety (68%)"
      ];
      "plugins/plugin-6/known-items" = [
        "vlc"
        "polychromatic-tray-applet"
        "blueman"
      ];

      "plugins/plugin-7" = "separator";
      "plugins/plugin-7/style" = 0;

      "plugins/plugin-8" = "clock";
      "plugins/plugin-8/mode" = 4;
      "plugins/plugin-8/show-meridiem" = false;
      "plugins/plugin-8/show-military" = false;

      "plugins/plugin-9" = "separator";
      "plugins/plugin-9/style" = 0;

      "plugins/plugin-10" = "actions";

      "plugins/plugin-19" = "cpugraph";
      "plugins/plugin-19/update-interval" = 3;
      "plugins/plugin-19/time-scale" = 0;
      "plugins/plugin-19/size" = 80;
      "plugins/plugin-19/mode" = 1;
      "plugins/plugin-19/color-mode" = 0;
      "plugins/plugin-19/frame" = 0;
      "plugins/plugin-19/border" = 0;
      "plugins/plugin-19/bars" = 1;
      "plugins/plugin-19/per-core" = 0;
      "plugins/plugin-19/tracked-core" = 0;
      "plugins/plugin-19/in-terminal" = 1;
      "plugins/plugin-19/startup-notification" = 0;
      "plugins/plugin-19/load-threshold" = 0;
      "plugins/plugin-19/smt-stats" = 0;
      "plugins/plugin-19/smt-issues" = 0;
      "plugins/plugin-19/per-core-spacing" = 1;
      "plugins/plugin-19/command" = "";
      "plugins/plugin-19/background" = [
        1.0
        1.0
        1.0
        0.0
      ];
      "plugins/plugin-19/foreground-1" = [
        0.0
        1.0
        0.0
        1.0
      ];
      "plugins/plugin-19/foreground-2" = [
        1.0
        0.0
        0.0
        1.0
      ];
      "plugins/plugin-19/foreground-3" = [
        0.0
        0.0
        1.0
        1.0
      ];
      "plugins/plugin-19/smt-issues-color" = [
        0.9
        0.0
        0.0
        1.0
      ];
      "plugins/plugin-19/foreground-system" = [
        0.9
        0.1
        0.1
        1.0
      ];
      "plugins/plugin-19/foreground-user" = [
        0.1
        0.4
        0.9
        1.0
      ];
      "plugins/plugin-19/foreground-nice" = [
        0.9
        0.8
        0.2
        1.0
      ];
      "plugins/plugin-19/foreground-iowait" = [
        0.2
        0.9
        0.4
        1.0
      ];

      "plugins/plugin-21" = "xfce4-sensors-plugin";

      "plugins/plugin-22" = "separator";
      "plugins/plugin-22/style" = 0;
    };

    xfwm4 = {
      "general/button_layout" = "CHM|T";
      "general/borderless_maximize" = true;
    };

    xfce4-desktop = {
      "desktop-icons/style" = 1;
      "desktop-icons/gravity" = 2;
      "desktop-icons/file-icons/show-device-fixed" = true;
      "desktop-icons/file-icons/show-device-removable" = false;
      "desktop-icons/file-icons/show-filesystem" = true;
      "desktop-icons/file-icons/show-home" = true;
      "desktop-icons/file-icons/show-network-removable" = false;
      "desktop-icons/file-icons/show-removable" = true;
      "desktop-icons/file-icons/show-trash" = false;
      "desktop-icons/file-icons/show-unknown-removable" = false;
    };
  };
}
