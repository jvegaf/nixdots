{
  inputs,
  pkgs,
  ...
}: let
  nsScript = pkgs.writeShellScriptBin "ns" ''
    exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.ns = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = nsScript;
      runtimeInputs = [
        pkgs.fzf
        pkgs.nix-search-tv
      ];
    };
  };
}
