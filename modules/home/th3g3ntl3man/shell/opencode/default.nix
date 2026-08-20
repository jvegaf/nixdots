{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  aiTools = import ../ai-tools/lib.nix { inherit lib; };

  superpowers = rec {
    src = inputs.superpowers;
    skills = "${src}/skills";
    opencode-plugin = "${src}/.opencode/plugins/superpowers.js";
  };
in
{
  imports = [
    ./permission.nix
    ./lsp.nix
  ];

  programs.opencode = {
    enable = true;

    package = inputs.llm-agents.packages.${pkgs.system}.opencode;

    enableMcpIntegration = true;

    settings = {
      autoshare = false;
      autoupdate = false;

      # provider = {
      #   ollama = {
      #     npm = "@ai-sdk/openai-compatible";
      #     name = "Ollama";
      #     options = {
      #       baseURL = "http://localhost:11434/v1";
      #     };
      #     models = {
      #       "qwen3.5:latest" = {
      #         name = "Qwen 3.5";
      #         limit = {
      #           context = 61440;
      #           output = 24576;
      #         };
      #       };
      #     };
      #   };
      # };

      plugin = [
        # Dynamic context pruning
        "@tarquinen/opencode-dcp@latest"
        # Support background shell commands
        "opencode-pty"

        "@mohak34/opencode-notifier@latest"
        "@tarquinen/opencode-smart-title"

        # "oh-my-opencode@latest"
        "@simonwjackson/opencode-direnv@latest"
      ];
    };

    commands = ../ai-tools/commands;
    agents = ../ai-tools/agents;

    skills = {
      skills = ../ai-tools/skills;
      superpowers = superpowers.skills;
    };

    context = builtins.readFile ../ai-tools/base.md;

    # extraPackages = with pkgs; [
    #
    # ];

  };
}
