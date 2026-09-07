{ ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        # HostName = "github.com";
        IdentityFile = "~/.ssh/id_ed25519";
        AddKeysToAgent = "yes";
      };
    };
  };
}
