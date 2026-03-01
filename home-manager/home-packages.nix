{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    mpv
    obsidian
    pavucontrol
    telegram-desktop

    # CLI utils
    brightnessctl
    cliphist
    ffmpeg
    ffmpegthumbnailer
    git-graph
    grimblast
    mediainfo
    playerctl
    showmethekey
    silicon
    udisks
    w3m
    wl-clipboard
    yt-dlp
    zip

    # WM stuff
    libnotify

    nodePackages.nodejs
    pnpm
    yarn



    # Other
    bemoji
    nix-prefetch-scripts
  ];
}
