{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.fm.thunar.enable = lib.mkEnableOption "Thunar file manager";

  config = lib.mkIf config.programs.fm.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };

    services = {
      tumbler.enable = true;
      gvfs.enable = true;
    };
  };
}
