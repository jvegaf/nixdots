{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Fantasque SansM Nerd Font:size=14";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      keybindings = {
        show-urls-launch = "Control+Shift+o";
      };
    };
  };
}
