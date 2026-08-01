{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.programs;
  inherit (lib) mkIf mkEnableOption mkMerge;
in
{
  options.modules.programs = {
    firefox.enable = mkEnableOption "Enable Firefox";
    brave.enable = mkEnableOption "Enable Brave";
  };
  imports = [ ./firefox ];

  config = mkMerge [
    (mkIf cfg.brave.enable {
      programs.brave.enable = true;
    })
  ];
}
