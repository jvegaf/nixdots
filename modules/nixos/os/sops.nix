{ inputs, config, ... }:
let
  homePath = "/home/th3g3ntl3man";
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${homePath}/.config/sops/age/keys.txt";

  sops.secrets.opencode_go_api_key = {
    owner = config.users.users.th3g3ntl3man.name;
  };

}
