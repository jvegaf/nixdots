{
  inputs,
  pkgs,
  lib,
  ...
}: let
  zshConfig = pkgs.writeText "zshrc" ''
    # Aliases
    alias sw="nh os switch"
    alias upd="nh os switch --update"
    alias hms="nh home switch"
    alias cdf="cd ~/flakes"

    alias ls="eza -lh --group-directories-first --icons=auto"
    alias l="ls"
    alias ll="ls -a"
    alias lt="eza --tree --level=2 --long --icons --git"
    alias llt="lt -a"
    alias rebuild="sudo nixos-rebuild switch"
    alias freb="sudo nixos-rebuild switch --flake ~/nixdots#razer-blade"
    alias jup="just up"
    alias jde="just deploy"
    alias r="ranger"
    alias v="nvim"
    alias se="sudoedit"
    alias y="yazi"
    alias b="bat"
    alias rmd="rm -rf"
    alias dots="cd ~/nixdots"
    alias doc="cd ~/Documents"
    alias dw="cd ~/Downloads"
    alias dt="cd ~/Desktop"
    alias cdc="cd ~/Code"
    alias mx="tmux"
    alias grep="grep --color=auto"
    alias ffe="fastfetch"
    alias bt="btop"
    alias jctl="journalctl -p 3 -xb"
    alias lzd="lazydocker"
    alias gb="nix-collect-garbage -d"
    alias clean="nh clean all --keep 3"

    alias g="lazygit"
    alias gs="git status"
    alias ga="git add"
    alias gaa="git add ."
    alias gc="git commit"
    alias gps="git push"
    alias gpl="git pull --rebase --autostash"
    alias gco="git checkout"
    alias gcl="git clone"

    alias ".."="cd .."
    alias "..."="cd ../.."
    alias "...."="cd ../../.."

    # History
    HISTSIZE=10000
    SAVEHIST=10000

    # Vi mode
    bindkey -v

    # Completion
    autoload -Uz compinit && compinit
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

    # Syntax highlighting
    if [[ -f ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi

    # Autosuggestions
    if [[ -f ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi

    # Keybindings
    bindkey '^[[A' history-search-backward
    bindkey '^[[B' history-search-forward
    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line
    bindkey '^[[3~' delete-char
    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.zsh = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zsh;
      runtimeInputs = [
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-autosuggestions
        pkgs.eza
        pkgs.zoxide
        pkgs.fzf
        pkgs.ripgrep
        pkgs.fd
        pkgs.bat
        pkgs.lazygit
        pkgs.tmux
        pkgs.yazi
        pkgs.ranger
        pkgs.fastfetch
        pkgs.btop
        pkgs.nh
        pkgs.just
        pkgs.nix-output-monitor
      ];
      flags = {
        "-C" = "source ${zshConfig}";
      };
    };
  };
}
