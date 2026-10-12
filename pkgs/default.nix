# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.creality-print = pkgs.callPackage ./creality-print.nix { };
      packages.flatcam = pkgs.callPackage ./flatcam.nix { };
    };
}
