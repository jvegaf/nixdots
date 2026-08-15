# VM test host (VirtualBox guest)
#
# Replica of the razer-blade desktop: GNOME + Hyprland (Lua config) +
# Noctalia, so anything migrated to the desktop can be tested here first.
# Enable UEFI in the VirtualBox VM settings (System -> Enable EFI).

{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/nixos/hardware
    ../../modules/nixos/os
    ../../modules/nixos/desktop/gnome
    ../../modules/nixos/desktop/hyprland
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "vm";

  # VirtualBox guest additions: clipboard, drag & drop, shared folders.
  virtualisation.virtualbox.guest = {
    enable = true;
    # Shared folders need the user in the vboxsf group.
  };

  users.users.th3g3ntl3man.extraGroups = [ "vboxsf" ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
