{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;

  users.users.th3g3ntl3man.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker
  ];
}
