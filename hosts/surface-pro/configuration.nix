{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nixos/modules
  ];

  networking.hostName = "surface-pro";
  system.stateVersion = "26.05"; # Did you read the comment?

}
