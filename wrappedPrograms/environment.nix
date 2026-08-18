{
  lib,
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    # Mi shell principal con todos los wrapped programs
    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zsh;
      runtimeInputs = [
        # Nix tools
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect

        # System tools
        pkgs.file
        pkgs.unzip
        pkgs.zip
        pkgs.p7zip
        pkgs.wget
        pkgs.killall
        pkgs.sshfs
        pkgs.fzf
        pkgs.htop
        pkgs.fd
        pkgs.zoxide
        pkgs.dust
        pkgs.ripgrep
        pkgs.neofetch
        pkgs.tree-sitter
        pkgs.imagemagick
        pkgs.ffmpeg-full
        pkgs.yt-dlp

        # Wrapped programs
        self'.packages.kitty
        self'.packages.git
        self'.packages.lazygit
        self'.packages.zsh
        self'.packages.starship
        self'.packages.bat
        self'.packages.eza
        self'.packages.btop
        self'.packages.nh
        self'.packages.fastfetch
        self'.packages.tmux
        self'.packages.zellij
        self'.packages.yazi
        self'.packages.helix
        self'.packages.tealdeer
        self'.packages.alacritty
        self'.packages.ghostty
        self'.packages.zed
        self'.packages.ns
      ];
      env = {
        EDITOR = lib.getExe self'.packages.zed;
        VISUAL = lib.getExe self'.packages.zed;
      };
    };
  };
}
