{ config, lib, ... }:
{
  imports = [
    ./server.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "th3g3ntl3man";
  home.homeDirectory = "/home/th3g3ntl3man";

  # Packages that should be installed to the user profile.
  # home.packages = [
  #   inputs.nixvim.packages.x86_64-linux.default
  # ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  home.activation.cleanupBrokenNvimConfig = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    nvim_dir="${config.xdg.configHome}/nvim"
    if { [ -L "$nvim_dir" ] && [ ! -d "$nvim_dir" ]; } || { [ -e "$nvim_dir" ] && [ ! -d "$nvim_dir" ]; }; then
      backup_ext="''${HOME_MANAGER_BACKUP_EXT:-hm-back}"
      backup_path="$nvim_dir.$backup_ext"
      if [ -e "$backup_path" ]; then
        backup_path="$backup_path.$(date +%s)"
      fi
      run mv "$nvim_dir" "$backup_path"
    fi
  '';

  xdg.enable = true;
  fonts.fontconfig.enable = true;

  # ensure ~/.nix-profile points at the managed Home Manager profile so packages resolve
  home.file.".nix-profile" = {
    source = config.home.path;
    force = true;
  };
}
