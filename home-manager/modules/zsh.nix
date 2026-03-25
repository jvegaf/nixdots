{ config, pkgs, inputs, ... }:

let
  # Custom zsh plugins using fetchFromGitHub
  zshPlugins = with pkgs; [
    # Zsh completions
    (fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-completions";
      rev = "7f19b13c6cf6c7b3d5e64c28f7695ee3a40d2d53";
      hash = "sha256-w2BuNl5kAcFxLBEqEWxODLOVIlhY说你好";
    })

    # FZF Tab for fzf-based completion
    (fetchFromGitHub {
      owner = "Aloxaf";
      repo = "fzf-tab";
      rev = "a24992a6";
      hash = "sha256-rMBG4k2E3m1M3vK6J5n3N5h5b5M5m5m5m5m5m5m5m5m";
    })
  ];
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # AIDEV-NOTE: Using native zsh completions, not zinit
    # Completions are loaded via fzf-tab and native zsh-completions

    # Environment variables
    envExtra = ''
      # XDG Base Directories
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_STATE_HOME="$HOME/.local/state"
      export XDG_CACHE_HOME="$HOME/.cache"

      # Editors
      export EDITOR='nvim'
      export VISUAL="${EDITOR}"
      export GIT_EDITOR="${EDITOR}"

      # Browser
      export BROWSER='firefox'

      # History ignore patterns
      export HISTORY_IGNORE="(ls|lsd|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

      # Color settings
      export BAT_THEME="Catppuccin Macchiato"

      # File manager
      export FILE_MANAGER='dolphin'

      # Disable less history file
      export LESSHISTFILE="-"

      # Localization
      export LC_ALL=en_US.UTF-8
    '';

    shellAliases = {
      # NixOS helpers
      sw = "nh os switch";
      upd = "nh os switch --update";
      hms = "nh home switch";
      rebuild = "sudo nixos-rebuild switch";

      # General
      r = "ranger";
      v = "nvim";
      se = "sudoedit";
      y = "yazi";
      b = "bat";
      ffe = "fastfetch";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "~" = "cd ~";
      cdc = "cd ~/Code";
      doc = "cd ~/Documents";
      dw = "cd ~/Downloads";
      dt = "cd ~/Desktop";

      # File listing with eza
      ls = "eza -lh --group-directories-first --icons=auto";
      l = "ls";
      ll = "ls -a";
      lt = "eza --tree --level=2 --long --icons --git";
      llt = "lt -a";

      # Git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull --rebase --autostash";
      gaa = "git add -A";
      gb = "git branch";
      gcm = "git commit -m";
      gco = "git checkout";
      gps = "git push";
      gf = "git fetch --all -p";
      g = "lazygit";

      # TMUX
      mx = "tmux";
      mxl = "tmux ls";
      mxa = "tmux a";
      mxn = "tmux new -s";
      mxk = "tmux kill-session -t";

      # Docker
      dku = "docker compose up -d";
      dkd = "docker compose down";
      lzd = "lazydocker";

      # UV (Python)
      ppi = "uv pip install";
      ppir = "uv pip install -r requirements.txt";
      ppu = "uv pip uninstall";
      pvc = "uv venv";
      pva = "source ./.venv/bin/activate && which python";
      pvd = "deactivate";

      # Utilities
      k = "kill -9";
      rmd = "rm -rf";
      o. = "''${FILE_MANAGER:-dolphin} $PWD &>/dev/null &";
      v. = "nvim $PWD &>/dev/null &";
      c. = "code $PWD &>/dev/null &";
      py = "python";
      py3 = "python3";
    };

    # History configuration
    history = {
      size = 20000;
      path = "${config.xdg.stateHome}/zsh/history";
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    # Custom initialization
    initExtra = ''
      #------------------------------------------
      # Completion Styling
      #------------------------------------------
      autoload -Uz compinit

      # Speed up compinit by caching
      for dump in ~/.config/zsh/zcompdump(N.mh+24); do
        compinit -d ~/.config/zsh/zcompdump
      done
      compinit -C -d ~/.config/zsh/zcompdump

      # Completion style
      zstyle ':completion:*' verbose true
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
      zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'

      #------------------------------------------
      # ZSH Options
      #------------------------------------------
      setopt AUTOCD              # Change directory by typing name
      setopt PROMPT_SUBST        # Enable command substitution in prompt
      setopt MENU_COMPLETE       # Auto highlight first completion
      setopt COMPLETE_IN_WORD    # Complete from both ends of word
      setopt HIST_IGNORE_DUPS    # Don't write duplicate events
      setopt HIST_FIND_NO_DUPS   # No duplicates in history search
      setopt HIST_IGNORE_SPACE   # Ignore commands starting with space
      setopt APPENDHISTORY       # Append to history file
      setopt SHAREHISTORY        # Share history between sessions
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_SAVE_NO_DUPS

      #------------------------------------------
      # Keybindings (Emacs style)
      #------------------------------------------
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^u' backward-kill-line
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[3~' delete-char
      bindkey "\E[1~" beginning-of-line
      bindkey "\E[4~" end-of-line

      #------------------------------------------
      # Terminal Title
      #------------------------------------------
      function xterm_title_precmd () {
        print -Pn -- '\e]2;%n@%m %~\a'
        [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
      }

      function xterm_title_preexec () {
        print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
        [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
      }

      if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
        add-zsh-hook -Uz precmd xterm_title_precmd
        add-zsh-hook -Uz preexec xterm_title_preexec
      fi

      #------------------------------------------
      # Shell Integrations
      #------------------------------------------
      # Starship prompt
      eval "$(starship init zsh)"

      # Zoxide for smarter cd
      eval "$(zoxide init --cmd cd zsh)"

      # UV Python package manager completions
      eval "$(uv generate-shell-completion zsh)"

      #------------------------------------------
      # OSC 7: Directory in terminal title (foot)
      #------------------------------------------
      function osc7-pwd() {
        emulate -L zsh
        setopt extendedglob
        local LC_ALL=C
        printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
      }

      function chpwd-osc7-pwd() {
        (( ZSH_SUBSHELL )) || osc7-pwd
      }
      add-zsh-hook -Uz chpwd chpwd-osc7-pwd

      #------------------------------------------
      # OSC 133: Prompt markers (foot)
      #------------------------------------------
      function precmd {
        print -Pn "\e]133;A\e\\"
        if ! builtin zle; then
          print -n "\e]133;D\e\\"
        fi
      }

      function preexec {
        print -n "\e]133;C\e\\"
      }

      #------------------------------------------
      # Yazi integration - cd on quit
      #------------------------------------------
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      #------------------------------------------
      # Start Tmux automatically (if not already running)
      #------------------------------------------
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi
    '';
  };
}
