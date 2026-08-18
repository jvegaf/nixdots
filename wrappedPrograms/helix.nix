{
  inputs,
  pkgs,
  lib,
  ...
}: let
  helixConfig = pkgs.writeTextDir "helix/config.toml" ''
    theme = "catppuccin_mocha"

    [editor]
    evil = true
    end-of-line-diagnostics = "hint"
    auto-pairs = true
    mouse = true
    middle-click-paste = true
    shell = ["zsh", "-c"]
    line-number = "absolute"
    auto-completion = true
    path-completion = true
    auto-info = true
    color-modes = true
    popup-border = "all"
    clipboard-provider = "wayland"
    indent-heuristic = "hybrid"

    [editor.statusline]
    left = ["mode", "spinner"]
    center = ["file-absolute-path", "total-line-numbers", "read-only-indicator", "file-modification-indicator"]
    right = ["diagnostics", "selections", "position", "file-encoding", "file-line-ending", "file-type"]
    separator = "│"
    mode.normal = "NORMAL"
    mode.insert = "INSERT"
    mode.select = "SELECT"

    [editor.lsp]
    enable = true
    display-messages = true
    display-progress-messages = true

    [editor.inline-diagnostics]
    cursor-line = "hint"
    other-lines = "hint"

    [keys.insert]
    j = { k = "normal_mode" }

    [keys.normal]
    W = ":write"
    "A-q" = ":bc"
    "A-," = ":bp"
    "A-." = ":bn"
    Z = { Z = ":wbc" }
  '';

  languagesConfig = pkgs.writeTextDir "helix/languages.toml" ''
    [language-server.nil]
    command = "nil"

    [language-server.lua]
    command = "lua-language-server"

    [language-server.json]
    command = "vscode-json-languageserver"

    [language-server.markdown]
    command = "marksman"
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.helix = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.evil-helix;
      runtimeInputs = with pkgs; [
        nil
        lua-language-server
        marksman
        taplo
        jq-lsp
        vscode-langservers-extracted
        bash-language-server
        awk-language-server
        clang-tools
        docker-compose-language-service
        docker-language-server
        typescript-language-server
        cmake-language-server
        jsonnet-language-server
        luaformatter
      ];
      env = {
        XDG_CONFIG_HOME = pkgs.runCommand "helix-config" {} ''
          mkdir -p $out/helix
          cp ${helixConfig}/helix/config.toml $out/helix/config.toml
          cp ${languagesConfig}/helix/languages.toml $out/helix/languages.toml
        '';
      };
    };
  };
}
