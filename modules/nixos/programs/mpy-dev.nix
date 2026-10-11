{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.mpy-dev.enable = lib.mkEnableOption "Micropython dev environment";

  config = lib.mkIf config.programs.mpy-dev.enable {
    environment.systemPackages = with pkgs; [
      (python314.withPackages (
        p: with p; [
          python314Packages.pyserial # for pico-w-go in vscode
        ]
      ))
      thonny
      mpy-utils
      vscode.fhs
      minicom
      adafruit-ampy
      rshell
    ];
  };
}
