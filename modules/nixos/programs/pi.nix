{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.ai.pi-agent.enable = lib.mkEnableOption "Pi Agent";

  config = lib.mkIf config.programs.ai.pi-agent.enable {
    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      pi
    ];
  };
}
