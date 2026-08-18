{inputs, ...}: {
  flake.nixosModules.hostMinis = {pkgs, lib, ...}: {
    imports = [
      inputs.self.nixosModules.base
      inputs.self.nixosModules.general

      # Desktop environment
      ../../modules/nixos/desktop/xfce
    ];

    networking.hostName = "minis-z83";
    networking.networkmanager.enable = true;
    networking.wireless.enable = lib.mkDefault false;

    system.stateVersion = "26.05";
  };
}
