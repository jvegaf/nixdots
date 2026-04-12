{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    # kdenlive
    # jetbrains.pycharm-professional
    # jre8
    # qemu
    # quickemu
  _1password
  _1password-gui
  alacritty
  curl
  eza
  fd
  fzf
  gh
  git
  git-extras
  git-lfs
  gnome-keyring
  kitty
  lazygit
  luarocks
  neovim
  nerd-fonts.fantasque-sans-mono
  nerd-fonts.jetbrains-mono
  nh
  ntfs3g
  openssh
  orca-slicer
  platformio-core
  power-profiles-daemon
  prusa-slicer
  qbittorrent
  ripgrep
  rofi
  rustup
  sad
  starship
  tealdeer
  tmux
  unar
  unrar
  unzip
  uv
  wget
  wireguard-tools
  xclip
  xsel
  yazi
  yaziPlugins.compress
  yaziPlugins.diff
  yaziPlugins.dupes
  yaziPlugins.git
  yaziPlugins.glow
  yaziPlugins.jump-to-char
  yaziPlugins.lazygit
  yaziPlugins.mediainfo
  yaziPlugins.piper
  yaziPlugins.relative-motions
  yaziPlugins.smart-enter
  yaziPlugins.smart-filter
  yaziPlugins.smart-paste
  yaziPlugins.sudo
  zoxide
  zsh
  ];
}
