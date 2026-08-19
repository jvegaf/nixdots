{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.tealdeer = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.tealdeer;
      flags = {
        "--config-file" = ./tealdeer-config.toml;
      };
    };
  };
}
