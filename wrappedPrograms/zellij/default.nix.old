{
  inputs,
  pkgs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.zellij = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zellij;
      env = {
        ZELLIJ_CONFIG_FILE = ./zellij-config.kdl;
      };
    };
  };
}
