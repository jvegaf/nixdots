{
  environment.sessionVariables = rec {
    # TERMINAL = "alacritty";
    EDITOR = "nvim";
    VISUAL = "nvim";
    # FILE_MANAGER = "nautilus";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
