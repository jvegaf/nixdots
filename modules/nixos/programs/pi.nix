{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.programs.pi-agent.enable = lib.mkEnableOption "Pi Agent";

  config = lib.mkIf config.programs.pi-agent.enable {
    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      pi
    ];
  };
}
