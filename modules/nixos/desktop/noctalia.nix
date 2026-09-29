{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # programs.noctalia = {
  #   enable = true;
  #   systemd.enable = true;
  #
  #   # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
  #   recommendedServices.enable = true;
  # };
}
