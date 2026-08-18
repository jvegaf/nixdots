{inputs, ...}: {
  flake.nixosModules.general = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      inputs.self.nixosModules.nix
    ];

    programs.zsh.enable = true;

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      description = "${config.preferences.user.name}'s account";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.zsh;
    };
  };
}
