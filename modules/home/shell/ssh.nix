{ ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github" = {
        HostName = "github.com";
        IdentityFile = "~/.ssh/jvegaf_ed25519";
        AddKeysToAgent = "yes";
      };
    };
  };
}
