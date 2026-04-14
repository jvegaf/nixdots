# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./modules/nixvim/nixvim.nix
  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    curl
    fd
    gnome-keyring
    nh
    # neovim
    ntfs3g
    openssh
    power-profiles-daemon
    wget
    wl-clipboard
    xclip
    xsel
  ];


  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    # polkitPolicyOwners = [ "${user}" ];
    polkitPolicyOwners = [ "th3g3ntl3man" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
        chromium
      '';
      mode = "0755";
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
