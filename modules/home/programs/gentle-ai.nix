{ inputs, ... }: {

  imports = [ inputs.gentle-ai-nix.homeManagerModules.default ];

  programs.gentle-ai = {
    enable = true;

    providers = {
      opencode.enable = true;
    };

    components = {
      skills.enable = true;
      persona.enable = true;
      permissions.enable = true;
      sdd.enable = false;
      theme.enable = true;
      engram.enable = true;
    };

    communityTools.codegraph.enable = true;

    persona = "Gentleman";

  };
}
