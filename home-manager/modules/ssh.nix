{ lib, ... } : {

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github" = {
        host = "github.com";
        identityFile = "~/.ssh/jvegaf_ed25519";
        addKeysToAgent = "yes";
      };
    };
  };
}
