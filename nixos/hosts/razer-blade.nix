{inputs, ...}: {
  flake.nixosModules.hostRazerBlade = {pkgs, ...}: {
    imports = [
      inputs.self.nixosModules.base
      inputs.self.nixosModules.general
      inputs.self.nixosModules.desktop

      inputs.self.nixosModules.thunar
      inputs.self.nixosModules.onepassword

      # Desktop environments
      ../../modules/nixos/desktop/gnome
      ../../modules/nixos/desktop/hyprland
    ];

    nixpkgs.config.allowUnfree = true;
    networking.hostName = "razer-blade";

    boot.kernelPackages = pkgs.linuxPackages_latest;

    system.stateVersion = "26.05";
  };
}
