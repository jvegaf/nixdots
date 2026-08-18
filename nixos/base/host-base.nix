# Host base wrapper — adds home-manager, NUR overlay, and disko
# Every host module imports this to get the common NixOS + HM wiring.
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
      inputs.home-manager.nixosModules.home-manager
    ];

    # NUR overlay
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];

    # Home Manager
    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
    home-manager.overwriteBackup = true;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = { inherit inputs; };
    home-manager.sharedModules = [
      {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
        ];
      }
    ];
    home-manager.users.th3g3ntl3man = import ../../modules/home/home.nix;
  };
}
