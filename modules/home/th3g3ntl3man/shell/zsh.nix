{
  pkgs,
  location,
  inputs,
  ...
}:
{
  imports = [ inputs.dev-assistant.homeManagerModules.default ];

  home.packages = with pkgs; [
    # get ssh information with fzf
    dig
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = {
          "rm -rf *" = "fg=black,bg=red";
        };
        styles = {
          "alias" = "fg=blue";
        };
        highlighters = [
          "main"
          "brackets"
          "pattern"
        ];
      };
      history.expireDuplicatesFirst = true;

      # search sub commands
      historySubstringSearch.enable = true;

      initContent = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

        # - The first argument to the function is the name of the command.
        # - You should make sure to pass the rest of the arguments to fzf.
        _fzf_comprun() {
          local command=$1
          shift

          case "$command" in
            cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
            export|unset) fzf --preview "eval 'echo ''${}'"         "$@" ;;
            ssh)          fzf --preview 'dig {}'                   "$@" ;;
            *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
          esac
        }

        # C-Backspace / C-Delete for word deletions
        bindkey "^[[127;5u" backward-kill-word

        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-colors '\'
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true
        _comp_options+=(globdots)

        # if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        #   tmux attach-session -t default || tmux new-session -s default
        # fi
      '';

      shellAliases = {
        rebuild = "nh os switch";
        create = "DevAssistant";
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";

        ls = "eza -lh --group-directories-first --icons=auto";
        l = "ls";
        ll = "ls -a";
        lt = "eza --tree --level=2 --long --icons --git";
        llt = "lt -a";
        freb = "sudo nixos-rebuild switch --flake ~/nixdots#razer-blade";
        r = "ranger";
        v = "nvim";
        se = "sudoedit";
        y = "yazi";
        b = "bat";
        rmd = "rm -rf";
        dots = "cd ~/nixdots";
        doc = "cd ~/Documents";
        dw = "cd ~/Downloads";
        dt = "cd ~/Desktop";
        cdc = "cd ~/Code";
        mx = "tmux";
        grep = "grep --color=auto";
        "v." = "(nvim $PWD &>/dev/null &)";
        "o." = "($FILE_MANAGER $PWD &>/dev/null &)";
        ffe = "fastfetch";
        bt = "btop";
        jctl = "journalctl -p 3 -xb";
        lzd = "lazydocker";
        # edalias = "nvim ~/nixdots/home-manager/modules/zsh.nix";

        gb = "nix-collect-garbage -d";
        clean = "nh clean all --keep 3";

        jup = "just up";
        jud = "just deploy";

        g = "lazygit";
        gs = "git status";
        ga = "git add";
        gaa = "git add .";
        gc = "git commit";
        gps = "git push";
        gpl = "git pull --rebase --autostash";
        gco = "git checkout";
        gcl = "git clone";

        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
      };
    };

    zoxide = {
      enable = true;
      # alias cd to z
      options = [ "--cmd cd" ];
    };

    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates.auto_update = true;
      };
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    dev-assistant.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
      # Ctrl - T | find file
      fileWidget.options = [ "--preview '$show_file_or_dir_preview'" ];
      # Alt - C | chang directory
      changeDirWidget.options = [ "--preview 'eza --tree --color=always {} | head -200'" ];
      # Ctrl - R
      historyWidget.options = [
        "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
      ];
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    eza.enable = true;
    btop.enable = true;
  };
}
