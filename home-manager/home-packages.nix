{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    anki
    imv
    mpv
    obsidian
    pavucontrol
    telegram-desktop
    _1password
    _1password-gui
    gnome-disk-utility
    localsend
    orca-slicer
    qbittorrent
    evince
    firefox

    # CLI utils
    alacritty
    bat
    bat-extras.core
    bc
    bottom
    brightnessctl
    btop
    cliphist
    curl
    eza
    fastfetch
    fd
    ffmpeg
    ffmpegthumbnailer
    fzf
    gh
    git
    git-extras
    git-graph
    git-lfs
    glow
    gnome-keyring
    grimblast
    hyprpicker
    kitty
    lazydocker
    lazygit
    mediainfo
    microfetch
    neovim
    ntfs3g
    openssh
    playerctl
    ripgrep
    rofi
    showmethekey
    rustup
    sad
    starship
    stow
    tealdeer
    tmux
    udisks
    ueberzugpp
    unar
    unrar
    unzip
    w3m
    wget
    wl-clipboard
    wtype
    yazi
    yaziPlugins.compress
    yaziPlugins.diff
    yaziPlugins.dupes
    yaziPlugins.git
    yaziPlugins.glow
    yaziPlugins.jump-to-char
    yaziPlugins.lazygit
    yaziPlugins.lsar
    yaziPlugins.mediainfo
    yaziPlugins.mime-ext
    yaziPlugins.mount
    yaziPlugins.ouch
    yaziPlugins.piper
    yaziPlugins.relative-motions
    yaziPlugins.smart-enter
    yaziPlugins.smart-filter
    yaziPlugins.smart-paste
    yaziPlugins.starship
    yaziPlugins.sudo
    yaziPlugins.vcs-files
    yt-dlp
    zip
    zoxide
    zsh
    zstd

    # Coding stuff
    platformio-core
    openjdk23
    nodejs
    python311
    pnpm
    yarn

    # WM stuff
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Fonts
    nerd-fonts._0xproto
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    noto-fonts

    # Other
    bemoji
    nix-prefetch-scripts
  ];
}
