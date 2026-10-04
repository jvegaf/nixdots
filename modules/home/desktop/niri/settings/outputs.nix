{
  wayland.windowManager.niri.settings.output = [
    # Main Monitor
    {
      _args = [ "eDP-1" ];
      scale = 1.25;
      mode = "2560x1440@60";
    }

    # VM Testing Monitor
    {
      _args = [ "Virtual-1" ];
      scale = 1.0;
      mode = "1920x1080";
    }
  ];
}
