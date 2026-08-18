{inputs, ...}: {
  flake.nixosModules.hostSurface = {pkgs, ...}: {
    imports = [
      inputs.self.nixosModules.base
      inputs.self.nixosModules.general
      inputs.self.nixosModules.thunar

      # Desktop environment
      ../../modules/nixos/desktop/sway
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
