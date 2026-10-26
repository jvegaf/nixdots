{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.solidcraft.enable = lib.mkEnableOption "SolidCraft";

  config = lib.mkIf config.programs.solidcraft.enable {
    environment.systemPackages = [
      inputs.solidcraft.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
