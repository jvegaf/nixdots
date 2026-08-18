# Host base wrapper — adds NUR overlay and disko
# Every host module imports this to get the common NixOS wiring.
{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.hostBase = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    # NUR overlay
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
  };
}
