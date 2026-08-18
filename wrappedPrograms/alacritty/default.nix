{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.alacritty = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.alacritty;
      flags = {
        "--config-file" = ./alacritty.toml;
      };
    };
  };
}
