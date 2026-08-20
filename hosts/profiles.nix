{
  inputs,
  self,
  location,
  lib',
  ...
}:
let
  inherit (inputs.nixpkgs.lib) concatLists nixosSystem;

  # combine hm flake input and the home module to be imported together
  homeManager = [
    inputs.home-manager.nixosModules.home-manager
    # inputs.zen-browser.homeModules.twilight
    ../modules/home # home-manager configurations for hosts that need home-manager
  ];

  specialArgs = {
    inherit
      inputs
      self
      lib'
      location
      ;
  };
in
{
  # Razer Blade 15
  razer-blade = nixosSystem {
    inherit specialArgs;
    # Modules that are used
    modules = [
      ./razer-blade
      ../modules/nixos
    ]
    ++ concatLists [ homeManager ];
  };

  # Surface Pro 4
  surface-pro = nixosSystem {
    inherit specialArgs;
    # Modules that are used
    modules = [
      ./surface-pro
      ../modules/nixos
    ]
    ++ concatLists [ homeManager ];
  };

  # Homelab
  minis-z83 = nixosSystem {
    inherit specialArgs;
    # system = "aarch64-linux";
    # Modules that are used
    modules = [
      ./minis-z83
      ../modules/nixos
    ]
    ++ concatLists [ homeManager ];
  };

  # minimal build for initial install
  minimal = nixosSystem {
    inherit specialArgs;
    # Modules that are used
    modules = [
      ./minimal
      ../modules/nixos
    ]
    ++ concatLists [ homeManager ];
  };
}
