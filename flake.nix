{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:jvegaf/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NVF (Neovim framework)
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    yazi.url = "github:sxyazi/yazi";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:nix-community/stylix";

    razerdaemon = {
      url = "github:encomjp/razer-control-revived";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
            { nixpkgs.config.allowUnfree = true; }
            ./hosts/razer-blade/configuration.nix
            ./nixos/modules/razer-blade.nix
            ./nixos/modules
            home-manager.nixosModules.home-manager
            {
              home-manager.users.th3g3ntl3man = ./home-manager/home.nix;
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
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/minis-z83/configuration.nix
            ./nixos/modules/server.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useUserPackages = true;
              home-manager.overwriteBackup = true;
              home-manager.users.th3g3ntl3man = ./home-manager/minimal.nix;
              home-manager.backupFileExtension = "backup";

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
            ./nixos/modules
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useUserPackages = true;
              home-manager.overwriteBackup = true;
              home-manager.users.th3g3ntl3man = ./home-manager/home.nix;
              home-manager.backupFileExtension = "backup";

            }
          ];
        };
      };
    };
}
