{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      # "https://noctalia.cachix.org"
      # "https://hyprland.cachix.org"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

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
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    mangowm.url = "github:mangowm/mango";
    mangowm.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    razerdaemon.url = "github:encomjp/razer-control-revived";
    razerdaemon.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents.url = "github:numtide/llm-agents.nix";

    # gentle-ai = {
    #   url = "github:decode2/gentle-ai/feat/issue-110-nixos-support";
    #   flake = false;
    # };

    # Daily-built AI coding agents (opencode, claude-code, codex, ...)
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      # Configuración de herramientas por arquitectura (devShells, treefmt, etc.)
      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell { };
      };

      # Salidas globales del Flake
      flake =
        let
          mkHost =
            {
              hostName,
              extraModules ? [ ],
              userModule ? ./modules/home/home.nix,
              extraSpecialArgs ? { },
            }:
            inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
              }
              // extraSpecialArgs;
              modules = [
                {
                  nixpkgs.overlays = [
                    # inputs.nur.overlays.default
                    # (final: prev: {
                    #   gentle-ai = final.callPackage ./pkgs/gentle-ai/default.nix { inherit inputs; };
                    # })
                  ];
                }
                ./hosts/${hostName}/configuration.nix
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = false;
                  home-manager.useUserPackages = true;
                  home-manager.overwriteBackup = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = { inherit inputs; };
                  home-manager.sharedModules = [
                    # {
                    #   nixpkgs.overlays = [
                    #     inputs.nur.overlays.default
                    #     # (final: prev: {
                    #     #   gentle-ai = final.callPackage ./pkgs/gentle-ai/default.nix { inherit inputs; };
                    #     # })
                    #   ];
                    # }
                  ];
                  home-manager.users.th3g3ntl3man = userModule;
                }
              ]
              ++ extraModules;
            };
        in
        {
          nixosConfigurations = {
            razer-blade = mkHost {
              hostName = "razer-blade";
              extraModules = [ inputs.disko.nixosModules.disko ];
            };

            fs0ciety = mkHost {
              hostName = "fs0ciety";
              userModule = ./modules/home/fsociety.nix;
              extraModules = [ inputs.disko.nixosModules.disko ];
            };

            minis-z83 = mkHost {
              hostName = "minis-z83";
              userModule = ./modules/home/minimal.nix;
              extraModules = [ inputs.disko.nixosModules.disko ];
            };

            surface-pro = mkHost {
              hostName = "surface-pro";
              # userModule = ./modules/home/sway.nix;
              extraSpecialArgs = {
                host = "surface-pro";
              };
              extraModules = [ inputs.disko.nixosModules.disko ];
            };

            vm = mkHost {
              hostName = "vm";
              extraModules = [ inputs.disko.nixosModules.disko ];
            };
          };
        };
    };
}
