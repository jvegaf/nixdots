{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.ai.opencode.enable = lib.mkEnableOption "OpenCode Agent";

  config = lib.mkIf config.programs.ai.opencode.enable {
    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      opencode
    ];
  };
}
