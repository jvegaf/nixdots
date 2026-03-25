{
  programs.lazygit = {
    enable = true;
    settings = {
      # Show icons in UI
      gui.showIcons = true;

      # Catppuccin Mocha theme colors
      gui.theme = {
        lightTheme = false;

        # Border colors
        activeBorderColor = [ "blue" "bold" ];
        inactiveBorderColor = [ "grey" ];

        # Selection colors
        selectedLineBgColor = [ "blue" ];
        selectedRangeBgColor = [ "blue" ];

        # Line number colors
        lineNumberColor = [ "grey" ];

        # Custom colors
        defaultFgColor = [ "white" ];
        defaultBgColor = [ "black" ];

        # guilt colors
        selectedLineBgColor = [ "blue" ];
      };

      # Nested view options
      # File panel
      showFileTree = true;

      # Refresh interval in milliseconds
      git.refreshInterval = 10;
    };
  };
}
