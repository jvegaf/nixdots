{
  programs.git = {
    enable = true;
    userName = "Jose Vega";
    userEmail = "josevega234@gmail.com";

    # Delta pager for beautiful diffs
    # Delta is enabled through delta package in home-packages.nix

    extraConfig = {
      # Fetch and prune
      fetch = {
        prune = true;
      };

      push = {
        default = "simple";
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };

      core = {
        # editor = "nvim";
        autocrlf = "input";
        trustctime = false;
        precomposeunicode = false;
        pager = "delta --dark";
        ignorecase = false;
        eol = "lf";
      };

      help = {
        autocorrect = 1;
      };

      diff = {
        tool = "vimdiff";
        compactionHeuristic = true;
        indentHeuristic = true;
        colorMoved = "default";
      };

      difftool = {
        prompt = false;
      };

      pull = {
        rebase = true;
      };

      init = {
        defaultBranch = "master";
      };

      # Filter for Large File Storage
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };

      # Credential helper for GitHub
      credential = {
        "https://github.com" = {
          helper = "";
          helper = "!/usr/bin/gh auth git-credential";
        };
        "https://gist.github.com" = {
          helper = "";
          helper = "!/usr/bin/gh auth git-credential";
        };
      };

      # Apply settings
      apply = {
        whitespace = "fix";
      };
    };

    # Delta colors for diffs
    deltaFeatures = with pkgs.gitAndTools.delta; [
      decorations
      file-style
      hunk-header-style
      syntax-theme
    ];

    ignores = [
      # IDE
      ".idea/"
      "*.iml"

      # OS
      ".DS_Store"
      "Thumbs.db"

      # Build
      "*.o"
      "*.so"
      "*.pyc"
      "__pycache__/"

      # Rust
      "target/"

      # Node
      "node_modules/"
      ".npm/"

      # Nix
      "result"
      "result-*"
    ];

    includes = [
      {
        path = "~/.config/git/aliases.gitconfig";
        condition = "gitdir:~/";
      }
    ];
  };
}
