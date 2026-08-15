{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    # Noctalia is launched from config/autostart.lua ("noctalia").
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Hyprland Lua configuration, migrated verbatim from the Arch dotfiles
  # (~/.dotfiles/os/linux/hypr). Noctalia (hyprland.lua require("noctalia"))
  # regenerates noctalia.lua at runtime, so it is written as a regular file
  # instead of a read-only store symlink.
  home.file = let
    hyprDir = ./hypr;
    configDir = ./hypr/config;
    configFiles =
      builtins.filter
      (name: builtins.match ".*\\.lua" name != null)
      (builtins.attrNames (builtins.readDir configDir));
  in
    {
      ".config/hypr/hyprland.lua".text = builtins.readFile "${hyprDir}/hyprland.lua";
      ".config/hypr/noctalia.lua".text = builtins.readFile "${hyprDir}/noctalia.lua";
      ".config/hypr/.luarc.json".text = builtins.readFile "${hyprDir}/.luarc.json";
      ".config/hypr/wallpapers".source = ./hypr/wallpapers;

      # Noctalia configuration, migrated verbatim from ~/.dotfiles/os/linux/noctalia.
      ".config/noctalia/config.toml".text = builtins.readFile ./noctalia/config.toml;
      ".config/noctalia/templates/noctwhspr-mic-osd.css".text = builtins.readFile ./noctalia/templates/noctwhspr-mic-osd.css;
    }
    // builtins.listToAttrs (map (file: {
      name = ".config/hypr/config/${file}";
      value.text = builtins.readFile "${configDir}/${file}";
    }) configFiles);
}
