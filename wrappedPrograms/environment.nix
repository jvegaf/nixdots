{
  lib,
  inputs,
  self,
  ...
}:
{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      # My whole desktop in one package, includes kityy terminal
      packages.desktop = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrappersModules.niri ];
        terminal = lib.getExe self'.packages.terminal;
        env = {
          EDITOR = lib.getExe self'.packages.neovim;
        };
      };

      # My primary flake terminal
      packages.terminal =
        (inputs.wrappers.wrapperModules.kitty.apply {
          inherit pkgs;
          imports = [ self.wrappersModules.kitty ];
          shell = lib.getExe self'.packages.environment;
        }).wrapper;

      # My primary flake shell with all of it's packages
      packages.environment = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.fish;
        runtimeInputs = [
          # nix
          pkgs.nil
          pkgs.nixd
          pkgs.statix
          pkgs.alejandra
          pkgs.manix
          pkgs.nix-inspect
          self'.packages.nh

          # other
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
          pkgs.tree-sitter
          pkgs.imagemagick
          pkgs.imv
          pkgs.ffmpeg-full
          pkgs.yt-dlp

          # wrapped
          self'.packages.neovimDynamic
          self'.packages.qalc
          self'.packages.lf
          self'.packages.git
          self'.packages.jujutsu
          self'.packages.nix-check-bin

          self'.packages.neovim
          self'.packages.lazygit
          self'.packages.zsh
          self'.packages.starship
          self'.packages.bat
          self'.packages.eza
          self'.packages.btop
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
          EDITOR = lib.getExe self'.packages.neovimDynamic;
        };
      };

      packages.nix-check-bin = pkgs.writeShellApplication {
        name = "nix-check-bin";
        text = ''
          $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
        '';
      };
    };
}
