{ pkgs, ... }:
{
  programs.yazi = {
    plugins = with pkgs.yaziPlugins; {
      inherit git;
    };

    initLua = ''
      require("git"):setup()
    '';

    settings.plugin = {
      prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];
    };
  };
}
