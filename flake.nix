{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf = {
      url = "github:NotAShelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, nvf, ... }@inputs:
    {
      nixosConfigurations.fs0ciety = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  specialArgs = inputs;
          modules = [
	    nvf.nixosModules.default
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              # home-manager.useUserPackages = true;
              home-manager.users.th3g3ntl3man = ./home.nix;
	      home-manager.backupFileExtension = "bkp";


              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
      };
    };
}
