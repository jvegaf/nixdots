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

  # VirtualBox guest additions: DISABLED (upstream bug).
  #
  # virtualbox-guest-additions 7.2.14 does not build against modern
  # kernels: vboxvideo/vbox_fb.c uses drm_fb_helper_alloc_fbi(), removed
  # in favor of drm_fb_helper_alloc_info(). Fails on 6.6/6.12/6.18 alike.
  # Tracked upstream: VirtualBox #467/#812, nixpkgs #363887.
  #
  # The desktop works without them (EFI framebuffer); only shared
  # folders (vboxsf), clipboard and drag&drop are lost. Re-enable when
  # the package builds again:
  #
  #   virtualisation.virtualbox.guest.enable = true;
  #   users.users.th3g3ntl3man.extraGroups = [ "vboxsf" ];
  virtualisation.virtualbox.guest.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?
}
