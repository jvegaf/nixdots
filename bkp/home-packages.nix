{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    # mpv
    # obsidian
    # pavucontrol
    # telegram-desktop

    # CLI utils
    bat
    # brightnessctl
    # cliphist
    # ffmpeg
    # ffmpegthumbnailer
    # git-graph
    # grimblast
    # mediainfo
    # playerctl
    # showmethekey
    # silicon
    # udisks
    # w3m
    # wl-clipboard
    # yt-dlp
    # zip

    # WM stuff
    # libnotify
    #
    # nodePackages.nodejs
    tree-sitter
    nodejs_24
    pnpm
    gcc
    gnumake
    cmake
    nil # Language Server
    statix # Lints and suggestions
    deadnix # Find and remove unused
    alejandra # Code Formatter
    luarocks
    # yarn



    # Other
    # bemoji
    # nix-prefetch-scripts
  ];
}
