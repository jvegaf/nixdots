{ pkgs, ... }: {

  imports = [
    ../vicinae
  ];

  # home.packages = with pkgs; [
  #   xwayland-satellite
  # ];

  # xdg.configFile."niri/config.kdl".source =
  #   pkgs.runCommand "niri-config-checked"
  #     {
  #       nativeBuildInputs = [ pkgs.niri ];
  #     }
  #     ''
  #       niri validate --config ${./config.kdl}
  #       cp ${./config.kdl} $out
  #     '';

  programs.niri = {
    enable = true;
    settings = {
      binds = {
        "Mod+Return".action.spawn = "kitty";
        "Mod+E".action.spawn = "nautilus";
        "Mod+B".action.spawn = "firefox";
        "Mod+D".action.spawn = "vicinae";
        "Mod+F".action.expand-column-to-available-width = 1;
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
      };
    };
  };

  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

}
