{ ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "dark:Catppuccin Frappe , light:Farmhouse Light";
      font-family = "JetBrainsMono NF";
      font-size = 12;
      gtk-titlebar = false;
      background-opacity = 0.8;
      shell-integration = "detect";
      unfocused-split-opacity = 0.4;
      maximize = true;
      confirm-close-surface = false;
      quit-after-last-window-closed = true;
    };
  };
}
