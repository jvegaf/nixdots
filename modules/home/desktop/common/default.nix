{ pkgs, ... }:
{
  imports = [
    # ./qt.nix
    ./zathura.nix
    # ./stylix.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
  ];
}
