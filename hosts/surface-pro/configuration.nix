{ inputs, ... }:

{
  imports = [
    # nix-hardware Surface specific modules using linux-surface patches
    inputs.hardware.nixosModules.microsoft-surface-pro-intel
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use patched kernel 6.15 for better webcam support (hopefully)
  hardware.microsoft-surface.kernelVersion = "stable";
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "surface-pro";
  system.stateVersion = "26.05"; # Did you read the comment?

}
