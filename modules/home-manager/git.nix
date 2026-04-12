{
  programs.git = {
    enable = true;
    settings.user.name = "Jose Vega";
    settings.user.email = "josevega234@gmail.com";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  
  programs.ssh = {
      enable = true;
      extraConfig = ''
          Host github.com
          IdentityFile ~/.ssh/jvegaf_ed25519
      '';
  };
}
