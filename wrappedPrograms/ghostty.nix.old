{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.ghostty = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.ghostty;
      runtimeInputs = [
        pkgs.bat
      ];
    };
  };
}
