{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.razer-blade = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostRazerBlade
    ];
  };

  flake.nixosModules.hostRazerBlade = {
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.hostBase
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop

      self.nixosModules.thunar
      self.nixosModules.onepassword

      # Desktop environments
      ../../modules/nixos/desktop/gnome
      ../../modules/nixos/desktop/hyprland

      # Hardware
      ./hardware-configuration.nix
      ./razer-blade.nix
      (import ../../hosts/disks/gpt-ext4.nix { device = "/dev/nvme0n1"; })
    ];

    nixpkgs.config.allowUnfree = true;
    networking.hostName = "razer-blade";

    boot.kernelPackages = pkgs.linuxPackages_latest;

    system.stateVersion = "26.05";
  };
}
