{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.docker;
in
{
  options.programs.docker.enable = lib.mkEnableOption "Docker Engine";

  config = lib.mkIf cfg.enable {

    virtualisation.docker.enable = true;

    users.users.th3g3ntl3man.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker
      lazydocker
    ];
  };
}
