{ pkgs, ... }: {

  home.packages = with pkgs; [
    android-studio-full
  ];

  programs.android-studio-full = {
    enable = true;
  };
}
