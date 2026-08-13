{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    yazi.url = "github:sxyazi/yazi";
    hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:nix-community/stylix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    razerdaemon.url = "github:encomjp/razer-control-revived";
    razerdaemon.inputs.nixpkgs.follows = "nixpkgs";

    niri-flake.url = "github:epireyn/niri-flake";
    niri-flake.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    # create nix project automatically
    dev-assistant.url = "github:spector700/DevAssistant";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    inputs@{ self, flake-parts, ... }:
    let
      # custom lib functions
      lib' = import ./lib;
      # main user for location
      user = "th3g3ntl3man";
      # Location of the nixos config
      location = "/home/${user}/nixdots";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      # systems for which the `perSystem` attributes will be built
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule

        # the flake utilities
        ./flake
        ./pkgs
      ];

      flake = {
        # entry-point for nixosConfigurations
        nixosConfigurations = import ./hosts/profiles.nix {
          inherit
            inputs
            self
            lib'
            location
            ;
        };
      };
    };
}
