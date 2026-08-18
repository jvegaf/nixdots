{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.minis-z83 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMinis
    ];
  };

  flake.nixosModules.hostMinis = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.hostBase
      self.nixosModules.base
      self.nixosModules.general

      # Desktop environment
      ../../modules/nixos/desktop/xfce

      # Hardware
      ./hardware-configuration.nix
      (import ../../hosts/disks/gpt-ext4.nix { device = "/dev/sda"; swapSize = "4G"; })
    ];

    networking.hostName = "minis-z83";
    networking.networkmanager.enable = true;
    networking.wireless.enable = lib.mkDefault false;

    system.stateVersion = "26.05";
  };
}
