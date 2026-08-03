{ ... }: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "$HOME/nixdots";
    # env = {
    #   "NH_FLAKE" = "$HOME/nixconf";
    # };

  };
}
