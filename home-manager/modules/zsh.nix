{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/flake";
      in
      {
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";

        pkgs = "nvim ${flakeDir}/nixos/packages.nix";

        ls = "eza -lh --group-directories-first --icons=auto";
        l = "ls";
        ll = "ls -a";
        lt = "eza --tree --level=2 --long --icons --git";
        llt = "lt -a";
        rebuild = "sudo nixos-rebuild switch";
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
        edalias = "nvim ~/nixdots/home-manager/modules/zsh.nix";
        nvcfg = "nvim ~/nixdots/home-manager/modules/neovim/nixvim.nix";

        nxgb = "nix-collect-garbage -d";
        nxclean = "nh clean all --keep 3";

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
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initContent = ''
      # Start Tmux automatically if not already running. No Tmux in TTY
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      # Start UWSM
      # if uwsm check may-start > /dev/null && uwsm select; then
      #   exec systemd-cat -t uwsm_start uwsm start default
      # fi
    '';
  };
}
