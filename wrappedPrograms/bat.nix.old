{
  inputs,
  pkgs,
  ...
}: let
  batConfig = pkgs.writeText "bat-config" ''
    --theme="Dracula"
    --style="numbers,changes,header,grid"
    --italic-text=always
    --map-syntax="*.conf:INI"
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.bat = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.bat;
      flags = {
        "--config-file" = batConfig;
      };
    };
  };
}
