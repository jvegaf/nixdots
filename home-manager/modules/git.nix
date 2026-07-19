{
  programs.git = {
    enable = true;
    settings.user.name = "Jose Vega";
    settings.user.email = "josevega234@gmail.com";
  };

  programs.git-lfs.enable = true;

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # programs.ssh = {
  #   enable = true;
  #   enableDefaultConfig = false;
  #
  #   matchBlocks = {
  #     "github" = {
  #       host = "github.com";
  #       identityFile = "~/.ssh/jvegaf_ed25519";
  #       addKeysToAgent = "yes";
  #     };
  #   };
  # };
}
