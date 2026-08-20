{
  lib,
  ...
}:

let
  inherit (lib) types mkOption;
in
{
  imports = [
    ./bar
    ./hyprland
    ./gnome
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./sway.nix
  ];

  options.modules.desktop = {
    bar = mkOption {
      type =
        with types;
        nullOr (enum [
          "dankMaterialShell"
          "noctalia"
          "waybar"
        ]);
      default = null;
      description = "Which bar to use";
    };
  };
}
