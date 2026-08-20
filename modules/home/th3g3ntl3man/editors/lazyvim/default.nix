{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.modules.editor.neovim;
in
{
  imports = [
    inputs.lazyvim.homeManagerModules.default
  ];

  config = mkIf (cfg == "lazyvim") {

    programs.lazyvim = {
      enable = true;
      configFiles = ./lazyconf;

      # Plugin source strategy
      pluginSource = "latest";

      extras = {
        ai.sidekick = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
          config = ''
            return {
              "folke/sidekick.nvim",
              opts = {
                cli = {
                  mux = {
                    backend = "tmux",
                    enabled = true,
                  },
                },
              }
            }
          '';
        };
        lang = {
          docker.enable = true;
          json.enable = true;
          markdown.enable = true;
          nix.enable = true;
          toml.enable = true;
          yaml.enable = true;
          clangd.enable = true;
          java.enable = true;
          kotlin.enable = true;
        };
        dap.core.enable = true;

        coding = {
          blink.enable = true;
          mini-comment.enable = true;
          mini-surround = {
            enable = true;
          };
        };

        editor = {
          snacks-explorer.enable = true;
          snacks-picker.enable = true;
          outline.enable = true;
          illuminate.enable = true;
          inc-rename.enable = true;
        };

        formatting.prettier.enable = true;
        linting.eslint.enable = true;

        util = {
          rest.enable = true;
          project.enable = true;
        };

        ui.smear-cursor.enable = true;
      };

      # Tools and LSP servers
      extraPackages = with pkgs; [
        nixd
        pyright
        alejandra
        ripgrep
        fd
        jdt-language-server
        kotlin-language-server
        statix
      ];
    };

  };
}
