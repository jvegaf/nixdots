{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = import ./nixvim.nix // {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      url-open
      urlview-nvim
    ];
  };
}
