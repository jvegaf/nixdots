{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      plugins = with pkgs.yaziPlugins; {
        gvfs = gvfs;
        chmod = chmod;
      };
      settings = {
        yazi = {
          mgr = {
            layout = [1 4 3];
            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            linemode = "size";
            show_hidden = true;
            show_symlink = true;
          };
          preview = {
            tab_size = 2;
            max_width = 1024;
            max_height = 1920;
          };
        };
        keymap = {
          mgr = {
            prepend_keymap = [
              { on = ["q"]; run = "close"; desc = "Close the current tab; if it's the last tab, exit the process instead."; }
              { on = ["g" "n"]; run = "cd ~/Nextcloud"; desc = "Go to Nextcloud"; }
              { run = "plugin gvfs -- select-then-mount jump"; on = ["M" "m"]; desc = "Mount and jump to device"; }
              { run = "plugin gvfs -- select-then-unmount --eject"; on = ["M" "u"]; desc = "Unmount and eject device"; }
              { run = "plugin gvfs -- jump-to-device"; on = ["g" "m"]; desc = "Jump to mounted device"; }
              { run = "plugin chmod"; on = ["c" "m"]; desc = "Chmod on selected files"; }
              { run = "tab_switch 1 --relative"; on = ["<C-Tab>"]; }
              { run = "tab_switch -1 --relative"; on = ["<C-BackTab>"]; }
              { on = "!"; run = ''shell "$SHELL" --block''; desc = "Open shell here"; }
            ];
          };
          cmp = {
            prepend_keymap = [
              { on = ["~"]; run = "help"; desc = "Open help"; }
            ];
          };
        };
      };
    };
  };
}
