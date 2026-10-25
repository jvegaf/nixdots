{
  wayland.windowManager.niri.settings.binds = {
    # Niri
    "Mod+Shift+Slash".show-hotkey-overlay = [ ];
    "Ctrl+Alt+Delete".quit = [ ];
    "Mod+O".toggle-overview = [ ];
    "Mod+Q".close-window = [ ];
    "Mod+Alt+Q".close-window = [ ];

    # Applications
    "Mod+B".spawn = "firefox";
    "Mod+Return".spawn = "alacritty";
    "Mod+S".spawn = [
      "kitty"
      "--class"
      "kitty-scratchpad"
    ];
    "Mod+E".spawn = [
      "nautilus"
      "--new-window"
    ];
  };
}
