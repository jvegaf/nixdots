{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/app-folders".folder-children = [
      "Utilities"
    ];
    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Papers.desktop"
        "org.gnome.Extensions.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.Logs.desktop"
        "cups.desktop"
        "nixos-manual.desktop"
      ];
      name = "Utilities";
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      show-battery-percentage = true;
      accent-color = "blue";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      monospace-font-name = "JetBrainsMono Nerd Font Mono Medium 11";
    };
    # Dash to Dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      dash-max-icon-size = 48;
      show-trash = false;
      show-mounts = false;
    };

    # Blur my shell
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
    };

    # Touchpad settings
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };

    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive";
    };
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/privacy".remember-recent-files = false;
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      begin-move = [ ];
      begin-resize = [ ];
      close = [ "<Super>q" ];
      cycle-group = [ ];
      cycle-group-backward = [ ];
      cycle-panels = [ ];
      cycle-panels-backward = [ ];
      cycle-windows = [ ];
      cycle-windows-backward = [ ];
      minimize = [ ];
      move-to-workspace-1 = [ ];
      move-to-workspace-last = [ ];
      switch-group = [ ];
      switch-group-backward = [ ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      switch-panels = [ ];
      switch-panels-backward = [ ];
      switch-to-workspace-1 = [ ];
      switch-to-workspace-last = [ ];
      toggle-maximized = [ ];
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };
    "org/gnome/mutter/wayland/keybindings".restore-shortcuts = [ ];
    "org/gnome/nautilus/icon-view".default-zoom-level = "small-plus";
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      help = [ ];
      magnifier = [ ];
      magnifier-zoom-in = [ ];
      magnifier-zoom-out = [ ];
      screenreader = [ ];
      home = [ "<Super>e" ];
      www = [ "<Super>b" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "Term";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>period";
      command = "ghostty";
      name = "Ghostty";
    };
    "org/gnome/shell" = {
      # disable-user-extensions = true;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        # "dash-to-dock@micxgx.gmail.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "gsconnect@andyholmes.github.io"
        "tophat@fflewddur.github.io"
      ];
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "alacritty.desktop"
        "kitty.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      screenshot = [ ];
      screenshot-window = [ ];
      toggle-application-view = [ ];
      toggle-message-tray = [ ];
      toggle-quick-settings = [ ];
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-column = "modified";
      sort-directories-first = true;
      sort-order = "descending";
    };
    "org/gtk/settings/file-chooser" = {
      sort-column = "modified";
      sort-directories-first = true;
      sort-order = "descending";
    };
    # Window management
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
    };

    # File manager
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
    };
  };

}
