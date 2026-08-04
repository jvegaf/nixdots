{ config, pkgs, ... }:

let
  # Ruta absoluta a tu repositorio de dotfiles
  dotfilesDir = "/home/th3g3ntl3man/nixdots";
in
{
  home.packages = with pkgs; [
    orca-slicer
  ];

  # Enlace simbólico fuera del Nix Store
  home.file.".config/OrcaSlicer".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/home/dotfiles/OrcaSlicer";
}
