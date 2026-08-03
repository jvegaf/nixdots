{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    yazi.url = "github:sxyazi/yazi";
    hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:nix-community/stylix";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    razerdaemon.url = "github:encomjp/razer-control-revived";
    razerdaemon.inputs.nixpkgs.follows = "nixpkgs";
    # Skills plugin for opencode
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };

    gentle-ai = {
      url = "github:decode2/gentle-ai/feat/issue-110-nixos-support";
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
            ./hosts/razer-blade/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.th3g3ntl3man = ./modules/home/home.nix;
              home-manager.useUserPackages = true;
              home-manager.overwriteBackup = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };

            }
          ];
        };

        minis-z83 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/minis-z83/configuration.nix
            ./nixos/modules/server.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useUserPackages = true;
              home-manager.overwriteBackup = true;
              home-manager.users.th3g3ntl3man = ./modules/home/minimal.nix;
              home-manager.backupFileExtension = "backup";

            }
          ];
        };

        surface-pro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            host = "surface-pro";
          };
          modules = [
            ./hosts/surface-pro/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                host = "surface-pro";
              };
              home-manager.useUserPackages = true;
              home-manager.overwriteBackup = true;
              home-manager.users.th3g3ntl3man = ./modules/home/home.nix;
              home-manager.backupFileExtension = "backup";

            }
          ];
        };
      };
    };
}
