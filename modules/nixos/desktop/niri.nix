{ pkgs, inputs, ... }:
{
  imports = [ inputs.niri-nix.nixosModules.default ];

  # Niri package overlay
  # nixpkgs.overlays = [ inputs.niri-nix.overlays.niri-nix ];
  programs.niri = {
    enable = true;
    # withUWSM = true;
    # package = pkgs.niri-unstable;
  };

  environment = {
    systemPackages = with pkgs; [ xwayland-satellite ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

}
