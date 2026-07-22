{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nixos/modules
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}
