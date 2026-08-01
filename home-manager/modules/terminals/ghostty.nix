{ ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "dark:Ayu ,light:Farmhouse Light";
      font = "JetBrainsMono NF";
      font-size = "13";
    };
  };
}
