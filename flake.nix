{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    };


    # stylix = {
    #   url = "github:danth/stylix/release-25.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Neovim configuration framework

    # Disko - declarative disk partitioning
    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.11";
      user = "th3g3ntl3man";
      hosts = [
        { hostname = "fs0ciety"; stateVersion = "25.11"; }
        { hostname = "h4z3"; stateVersion = "25.11"; }
        { hostname = "wh1t3r0s3"; stateVersion = "25.11"; }
      ];

      makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs stateVersion hostname user;
        };

        modules = [
	  {
            nixpkgs.config.allowUnfree = true;
	  }
          ./hosts/${hostname}/configuration.nix
        ];
      };

    in
    {
      nixosConfigurations = nixpkgs.lib.foldl'
        (configs: host:
          configs // {
            "${host.hostname}" = makeSystem {
              inherit (host) hostname stateVersion;
            };
          })
        { }
        hosts;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs homeStateVersion user;
        };

        modules = [
	  nixvim.homeModules.nixvim
          ./home-manager/home.nix
        ];
      };
    };
}
