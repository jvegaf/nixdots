{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostVm
    ];
  };

  flake.nixosModules.hostVm =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.hostBase
        self.nixosModules.base
        self.nixosModules.general

        # Hardware
        self.nixosModules.vmHardware

        inputs.disko.nixosModules.disko
        self.diskoConfigurations.vm
      ];

      nixpkgs.config.allowUnfree = true;
      networking.hostName = "vm";

      virtualisation.virtualbox.guest.enable = false;

      system.stateVersion = "26.05";
    };
}
