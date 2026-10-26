{ inputs, config, ... }:
let
  homePath = "/home/th3g3ntl3man";
  me = config.users.users.th3g3ntl3man.name;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${homePath}/.config/sops/age/keys.txt";
  sops.secrets = {
    OPENCODE_GO_API_KEY = {
      owner = me;
    };
    CONTEXT7_API_KEY = {
      owner = me;
    };
  };

}
