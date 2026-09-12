{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.blender.enable = lib.mkEnableOption "Blender";

  config = lib.mkIf config.programs.blender.enable {
    environment.systemPackages = [
      pkgs.blender
    ];
  };
}
