{ inputs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
      inputs.nixvim.packages.x86_64-linux.default
  ];

}
