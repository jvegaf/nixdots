{ pkgs, ... }:
{

  home.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    open-sans
    noto-fonts
    liberation_ttf_v2
    dejavu_fonts
    cantarell-fonts
  ];

  fonts.fontconfig.enable = true;
}
