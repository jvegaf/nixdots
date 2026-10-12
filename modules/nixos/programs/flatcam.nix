{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.flatcam.enable = lib.mkEnableOption "FlatCAM";

  config = lib.mkIf config.programs.flatcam.enable {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.flatcam
    ];
  };
}
