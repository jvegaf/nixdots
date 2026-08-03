{ ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "dark:Ayu , light:Farmhouse Light";
      font-family = "JetBrainsMono NF";
      font-size = 12;
      gtk-titlebar = false;
      background-opacity = 0.8;
    };
  };
}
