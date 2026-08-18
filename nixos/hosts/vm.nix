{inputs, ...}: {
  flake.nixosModules.hostVm = {...}: {
    imports = [
      inputs.self.nixosModules.base
      inputs.self.nixosModules.general

      # Desktop environments
      ../../modules/nixos/desktop/gnome
      ../../modules/nixos/desktop/hyprland
    ];

    nixpkgs.config.allowUnfree = true;
    networking.hostName = "vm";

    virtualisation.virtualbox.guest.enable = false;

    system.stateVersion = "26.05";
  };
}
