{ inputs, homeStateVersion, user, ... }: {
  imports = [
    ./home-packages.nix
    ./modules
    inputs.kickstart-nixvim.homeManagerModules.default
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
  
}
