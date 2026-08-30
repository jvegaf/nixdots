{

  qt.enable = false;
  xfconf.settings = {
    xsettings = {
      "Gtk/CursorThemeName" = "Capitaine Cursors";
      "Gtk/DecorationLayout" = "close,minimize,maximize:";
      "Net/IconThemeName" = "Colloid-Purple-Catppuccin-Dark";
      "Net/ThemeName" = "Layan-Dark";
      "Gtk/FontName" = "Ubuntu Sans Medium 10";
      "Gtk/MonospaceFontName" = "JetBrains Mono NL Medium 10";
    };

    xfce4-panel = {
      "panels" = [
        1
        2
      ];
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
      "panels/panel-2/autohide-behavior" = 1;
      "panels/panel-2/position" = "p=5;x=25;y=322";
      "panels/panel-2/length" = 1.0;
      "panels/panel-2/position-locked" = true;
      "panels/panel-2/size" = 48;
      "panels/panel-2/plugin-ids" = [
        1
        2
        17
        12
        13
      ];
      "panels/panel-2/mode" = 1;

      "plugins/plugin-3" = "separator";
      "plugins/plugin-3/expand" = true;
      "plugins/plugin-3/style" = 0;
      "plugins/plugin-5" = "separator";
      "plugins/plugin-5/style" = 0;
      "plugins/plugin-6" = "systray";
      "plugins/plugin-6/square-icons" = true;

      "plugins/plugin-7" = "separator";
      "plugins/plugin-7/style" = 0;

      "plugins/plugin-8" = "clock";
      "plugins/plugin-8/mode" = 4;
      "plugins/plugin-8/show-meridiem" = false;
      "plugins/plugin-8/show-military" = false;

      "plugins/plugin-9" = "separator";
      "plugins/plugin-9/style" = 0;

      "plugins/plugin-17" = "separator";

      "plugins/plugin-12" = "tasklist";
      "plugins/plugin-12/show-labels" = false;
      "plugins/plugin-12/show-handle" = false;
      "plugins/plugin-12/show-tooltips" = true;
      "plugins/plugin-12/grouping" = false;
      "plugins/plugin-12/switch-workspace-on-unminimize" = true;
      "plugins/plugin-12/sort-order" = 0;

      "plugins/plugin-13" = "thunar-tpa";

      "plugins/plugin-1" = "whiskermenu";
      "plugins/plugin-1/view-mode" = 1;
      "plugins/plugin-1/launcher-icon-size" = 2;
      "plugins/plugin-1/launcher-show-name" = false;
      "plugins/plugin-1/category-show-name" = true;
      "plugins/plugin-1/launcher-show-tooltip" = true;
      "plugins/plugin-1/launcher-show-description" = false;
      "plugins/plugin-1/position-categories-horizontal" = false;
      "plugins/plugin-1/position-categories-alternate" = true;
      "plugins/plugin-1/position-profile-alternate" = false;
      "plugins/plugin-1/position-search-alternate" = false;
      "plugins/plugin-1/button-icon" = "distributor-logo-nixos";
      "plugins/plugin-1/default-category" = 1;
      "plugins/plugin-1/recent" = [
        "kitty.desktop"
        "xfce-settings-manager.desktop"
        "xfce4-file-manager.desktop"
      ];

      "plugins/plugin-2" = "launcher";
      "plugins/plugin-2/items" = [ "17879265501.desktop" ];
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
