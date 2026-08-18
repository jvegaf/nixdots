{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://noctalia.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
    wrappers.url = "github:Lassulus/wrappers";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    razerdaemon.url = "github:encomjp/razer-control-revived";
    razerdaemon.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Daily-built AI coding agents (opencode, claude-code, codex, ...)
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./parts.nix
        ./wrappedPrograms
        ./nixos/base/user.nix
        ./nixos/base/monitors.nix
        ./nixos/base/keymap.nix
        ./nixos/features/nix.nix
        ./nixos/features/gtk.nix
        ./nixos/features/pipewire.nix
        ./nixos/features/desktop.nix
        ./nixos/features/firefox.nix
        ./nixos/features/chromium.nix
        ./nixos/features/general.nix
        ./nixos/features/thunar.nix
        ./nixos/features/1password.nix
        ./nixos/features/docker.nix
        ./nixos/features/ollama.nix
        ./nixos/base/host-base.nix
        ./nixos/hosts/razer-blade/configuration.nix
        ./nixos/hosts/minis/configuration.nix
        ./nixos/hosts/surface/configuration.nix
        ./nixos/hosts/vm/configuration.nix
      ];

      systems = [ "x86_64-linux" ];

      # Configuración de herramientas por arquitectura (devShells, treefmt, etc.)
      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell { };
      };
    };
}
