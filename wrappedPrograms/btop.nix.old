{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.btop = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.btop;
    };
  };
}
