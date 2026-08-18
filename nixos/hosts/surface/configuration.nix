{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.surface-pro = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSurface
    ];
  };

  flake.nixosModules.hostSurface = {
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.hostBase
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.thunar

      # Desktop environment
      ../../modules/nixos/desktop/sway

      # Hardware
      ./hardware-configuration.nix
      (import ../../hosts/disks/gpt-ext4.nix { device = "/dev/nvme0n1"; swapSize = "4G"; })
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "surface-pro";

    system.stateVersion = "26.05";
  };
}
