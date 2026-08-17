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
in
{
  imports = [
    ./permission.nix
    ./lsp.nix
    # ./oh-my-opencode.nix
  ];

  programs.opencode = {
    enable = true;

    # Daily-built opencode from numtide/llm-agents.nix (binary cache)
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;

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

        # "oh-my-opencode@latest"
        "@simonwjackson/opencode-direnv@latest"
      ];
    };

    commands = ../ai-tools/commands;
    agents = ../ai-tools/agents;

    skills = {
      skills = ../ai-tools/skills;
    };

    context = builtins.readFile ../ai-tools/base.md;

    # extraPackages = with pkgs; [
    #
    # ];

  };
}
