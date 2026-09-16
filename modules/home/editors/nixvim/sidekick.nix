{ pkgs, ... }:
{
  keymaps = [
    {
      key = "<leader>aa";
      mode = "n";
      action = "<cmd>lua require('sidekick.cli').toggle()<CR>";
      options.desc = "Sidekick Toggle CLI";
    }
    {
      key = "<leader>as";
      mode = "n";
      action = "<cmd>lua require('sidekick.cli').select()<CR>";
      options.desc = "Sidekick Select Tool";
    }
    {
      key = "<leader>ad";
      mode = "n";
      action = "<cmd>lua require('sidekick.cli').close()<CR>";
      options.desc = "Sidekick Close Session";
    }
    {
      key = "<leader>at";
      mode = "n";
      action = "<cmd>lua require('sidekick.cli').send({ msg = '{this}' })<CR>";
      options.desc = "Sidekick Send Context";
    }
    {
      key = "<leader>af";
      mode = "n";
      action = "<cmd>lua require('sidekick.cli').send({ msg = '{file}' })<CR>";
      options.desc = "Sidekick Send File";
    }
    {
      key = "<leader>av";
      mode = "x";
      action = "<cmd>lua require('sidekick.cli').send({ msg = '{selection}' })<CR>";
      options.desc = "Sidekick Send Selection";
    }
  ];

  plugins = {
    copilot-lua = {
      enable = true;
      # v3.0.4 was retagged upstream; pin its immutable commit and source hash.
      package = pkgs.vimPlugins.copilot-lua.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "zbirenbaum";
          repo = "copilot.lua";
          rev = "9d391a02dc0281713cbb7c3bc87cdd38287b92eb";
          hash = "sha256-kDQOm7/N6T7wOw1JlkcxNMnQrDE4oTRyGCZkvT8HZQw=";
        };
      });
    };

    sidekick = {
      enable = true;
      settings = {
        # Next Edit Suggestions (NES) - Multi-line refactorings from Copilot
        nes = {
          enabled = false;
          debounce = 100;
          diff = {
            inline = "words";
          };
          trigger = {
            events = [
              "ModeChanged i:n"
              "TextChanged"
              "User SidekickNesDone"
            ];
          };
          clear = {
            events = [
              "TextChangedI"
              "InsertEnter"
              "esc"
            ];
            esc = true;
          };
        };

        # CLI Terminal Integration
        cli = {
          watch = true;
          mux = {
            backend = "tmux";
            enabled = true;
            create = "terminal";
          };
          win = {
            layout = "right";
            split = {
              width = 80;
              height = 20;
            };
          };

          # Use external opencode from autopkgs (not nixvim's bundled version)
          tools = {
            opencode = {
              cmd = [ "opencode" ]; # Uses autopkgs.opencode from PATH
            };
          };
        };
      };
    };
  };
}
