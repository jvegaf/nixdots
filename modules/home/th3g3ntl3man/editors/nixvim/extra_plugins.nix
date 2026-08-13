{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
      url-open
      urlview-nvim
  ];
}
