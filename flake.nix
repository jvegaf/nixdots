{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Akari.url = "github:spector700/Akari";
    # khanelivim.url = "github:khaneliman/khanelivim";
    nvix.url = "github:semi710/nvix";

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
      nixosConfigurations = {
        razer-blade = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/razer-blade/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.th3g3ntl3man = ./home-manager/home.nix;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };

            }
          ];
        };

        surface-pro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/surface-pro/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useUserPackages = true;
              home-manager.users.th3g3ntl3man = ./home-manager/home.nix;
              home-manager.backupFileExtension = "backup";

            }
          ];
        };
      };
    };
}
