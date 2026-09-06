{ inputs, pkgs, ... }:
{
  imports = [
    ./browsers
    ./common
    ./desktop/common
    ./desktop/mango
    ./editors
    ./opencode
    ./shell
    ./terminals
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
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
