{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.creality-print.enable = lib.mkEnableOption "Creality Print";

  config = lib.mkIf config.programs.creality-print.enable {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.creality-print
    ];
  };
}
