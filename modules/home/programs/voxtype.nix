{ pkgs, inputs, ... }: {

  imports = [
    inputs.voxtype.homeManagerModules.default
  ];

  programs.voxtype = {
    enable = true;
    package = inputs.voxtype.packages.${pkgs.stdenv.hostPlatform.system}.vulkan;
    model.name = "small";
    service.enable = true;
    settings = {
      hotkey = {
        enabled = false;
      };
      whisper = {
        language = "es";
      };
    };
  };
}
