{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-25.11";
    

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgsStable";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    # };
    kickstart-nixvim = {
      # url = "github:JMartJonesy/kickstart.nixvim";
      url = "path:home-manager/modules/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = { self, nixpkgs, nixpkgsStable, home-manager, kickstart-nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.11";
      user = "th3g3ntl3man";
      hosts = [
        { hostname = "fs0ciety"; stateVersion = "25.11"; }
        { hostname = "h4z3"; stateVersion = "25.11"; }
        { hostname = "wh1t3r0s3"; stateVersion = "25.11"; }
      ];

      makeSystem = { hostname, stateVersion }: nixpkgsStable.lib.nixosSystem {
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
      nixosConfigurations = nixpkgsStable.lib.foldl'
        (configs: host:
          configs // {
            "${host.hostname}" = makeSystem {
              inherit (host) hostname stateVersion;
            };
          })
        { }
        hosts;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgsStable.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs homeStateVersion user;
        };

        modules = [
	  # nixvim.homeModules.nixvim
          ./home-manager/home.nix
        ];
      };
    };
}
