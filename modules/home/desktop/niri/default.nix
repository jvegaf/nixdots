{
  inputs,
  pkgs,
  ...
}:
{
  # https://codeberg.org/BANanaD3V/niri-nix

  imports = [
    inputs.niri-nix.homeModules.default
    ../noctalia-v5
    ./settings/input.nix
    ./settings/layout.nix
    ./settings/startup.nix
    ./settings/workspaces.nix
    ./settings/keybinds/columns.nix
    ./settings/keybinds/media.nix
    ./settings/keybinds/noctalia.nix
    ./settings/keybinds/system.nix
    ./settings/keybinds/utilities.nix
    ./settings/keybinds/workspace.nix
    ./settings/window-rules/blur.nix
    ./settings/window-rules/floating.nix
    ./settings/window-rules/full-screen.nix
  ];

  wayland.windowManager.niri.enable = true;

  home.packages = with pkgs; [
    nautilus
    sushi
    parole
  ];
}
