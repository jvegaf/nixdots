{ pkgs, ... }: {
  home.packages = with pkgs; [
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".source =
    pkgs.runCommand "niri-config-checked"
      {
        nativeBuildInputs = [ pkgs.niri ];
      }
      ''
        niri validate --config ${./config.kdl}
        cp ${./config.kdl} $out
      '';

  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

}
