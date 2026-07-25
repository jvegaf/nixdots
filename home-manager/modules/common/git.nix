{
  programs.git = {
    enable = true;
    settings.user.name = "Jose Vega";
    settings.user.email = "josevega234@gmail.com";
    lfs.enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
