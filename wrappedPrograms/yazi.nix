{
  inputs,
  pkgs,
  lib,
  ...
}: let
  yaziConfig = pkgs.writeTextDir "yazi/yazi.toml" ''
    [mgr]
    layout = [1, 4, 3]
    sort_by = "natural"
    sort_sensitive = true
    sort_reverse = false
    sort_dir_first = true
    linemode = "size"
    show_hidden = true
    show_symlink = true

    [pick]
    open_title = "Open with:"
    open_origin = "hovered"
    open_offset = [0, 1, 50, 7]

    [preview]
    tab_size = 2
    max_width = 1024
    max_height = 1920

    [[plugin.prepend_preloaders]]
    url = "/run/user/1000/gvfs/**/*"
    run = "noop"

    [[plugin.prepend_previewers]]
    url = "*/"
    run = "folder"

    [[plugin.prepend_previewers]]
    url = "/run/user/1000/gvfs/**/*"
    run = "noop"
  '';

  yaziKeymap = pkgs.writeTextDir "yazi/keymap.toml" ''
    [cmp]
    [[cmp.prepend_keymap]]
    on = ["~"]
    run = "help"
    desc = "Open help"

    [mgr]
    [[mgr.prepend_keymap]]
    on = ["q"]
    run = "close"
    desc = "Close the current tab; if it's the last tab, exit the process instead."

    [[mgr.prepend_keymap]]
    on = ["g", "n"]
    run = "cd ~/Nextcloud"
    desc = "Go to Nextcloud"

    [[mgr.prepend_keymap]]
    run = "plugin gvfs -- select-then-mount jump"
    on = ["M", "m"]
    desc = "Mount and jump to device"

    [[mgr.prepend_keymap]]
    run = "plugin gvfs -- select-then-unmount --eject"
    on = ["M", "u"]
    desc = "Unmount and eject device"

    [[mgr.prepend_keymap]]
    run = "plugin gvfs -- jump-to-device"
    on = ["g", "m"]
    desc = "Jump to mounted device"

    [[mgr.prepend_keymap]]
    run = "plugin chmod"
    on = ["c", "m"]
    desc = "Chmod on selected files"

    [[mgr.prepend_keymap]]
    run = "tab_switch 1 --relative"
    on = ["<C-Tab>"]

    [[mgr.prepend_keymap]]
    run = "tab_switch -1 --relative"
    on = ["<C-BackTab>"]

    [[mgr.prepend_keymap]]
    on = "!"
    run = 'shell "$SHELL" --block'
    desc = "Open shell here"
  '';

  yaziInitLua = pkgs.writeTextDir "yazi/init.lua" ''
    require("gvfs"):setup({})
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.yazi = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.yazi;
      runtimeInputs = [
        pkgs.ripdrag
        pkgs.yaziPlugins.gvfs
        pkgs.yaziPlugins.chmod
      ];
      env = {
        YAZI_CONFIG_HOME = yaziConfig;
        YAZI_KEYMAP_HOME = yaziKeymap;
      };
    };
  };
}
