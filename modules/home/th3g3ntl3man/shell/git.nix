# Git
#
{ config, ... }:
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      ignores = [
        ".direnv"
        "result"
        "node_modules"
      ];

      settings = {
        extraConfig = {
          init = {
            defaultBranch = "main";
          };

          core.askPass = "";

          diff.colorMoved = "default";
          commit.gpgSign = false;
          gpg.format = "ssh";
          user.signingkey = "${config.home.homeDirectory}/.ssh/gitkey";

          push = {
            default = "current";
            followTags = true;
            autoSetupRemote = true;
          };
          signing = {
            signByDefault = false;
            key = "${config.home.homeDirectory}/.ssh/gitkey";
          };
        };

        user = {
          email = "josevega234@gmail.com";
          name = "Jose Vega";
        };
      };
    };
  };
}
