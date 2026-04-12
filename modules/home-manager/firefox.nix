{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    languagePacks = [ "en-US" ];

  };
}
