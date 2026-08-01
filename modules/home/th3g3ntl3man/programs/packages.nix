{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  cfg = osConfig.modules.display.desktop;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.isWayland {
    home.packages = with pkgs; [
      # Terminal Utils
      fastfetch
      wl-clipboard

      # Video/Audio
      mpv
      loupe
      celluloid
      pwvucontrol
      vlc

      # signal-desktop
      # obsidian
      anki
      vial
    ];
  };
}
