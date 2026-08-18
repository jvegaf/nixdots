{
  inputs,
  pkgs,
  lib,
  ...
}: let
  zedConfigDir = pkgs.runCommand "zed-config" {} ''
    mkdir -p $out/zed
    cp ${./zed-config/settings.json} $out/zed/settings.json
    cp ${./zed-config/keymap.json} $out/zed/keymap.json
  '';
in {
  perSystem = {pkgs, ...}: {
    packages.zed = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zed-editor;
      runtimeInputs = with pkgs; [
        nixd
        nixfmt
        shellcheck
        shfmt
        stylua
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
        ZED_CONFIG_HOME = zedConfigDir;
      };
    };
  };
}
