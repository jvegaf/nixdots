{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostVm
    ];
  };

  flake.nixosModules.hostVm = {
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.hostBase
      self.nixosModules.base
      self.nixosModules.general

      # Desktop environments
      ../../modules/nixos/desktop/gnome
      ../../modules/nixos/desktop/hyprland

      # Hardware
      ./hardware-configuration.nix
      (import ../../hosts/disks/gpt-ext4.nix { device = "/dev/sda"; })
    ];

    nixpkgs.config.allowUnfree = true;
    networking.hostName = "vm";

    virtualisation.virtualbox.guest.enable = false;

    system.stateVersion = "26.05";
  };
}
