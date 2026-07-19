{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Akari.url = "github:spector700/Akari";
    khanelivim.url = "github:khaneliman/khanelivim";

    # Skills plugin for opencode
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.razer-blade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.th3g3ntl3man = ./home-manager/home.nix;
            home-manager.backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
