{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users.users.th3g3ntl3man = {
    isNormalUser = true;
    description = "The Gentleman";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
    # packages = with pkgs; [
    #   kdePackages.kate
    # #  thunderbird
    # ];
  };
}
