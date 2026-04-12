{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.jetbrains-mono
      open-sans
      noto-fonts
    ];

    fontconfig.enable = true;
  };
}
