{ pkgs, ... }: {

  home.packages = with pkgs; [
    tor-browser
  ];

  programs.tor-browser.enable = true;
}
