{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cairo
        clojure
        cmake
        comment
        cpp
        css
        csv
        dockerfile
        dot
        doxygen
        dtd
        editorconfig
        fish
        fsh
        git-config
        git-rebase
        gitattributes
        gitcommit
        gitignore
        html
        http
        hyprlang
        ini
        java
        javascript
        jinja
        jq
        jsdoc
        json
        json5
        just
        kdl
        lua
        luadoc
        make
        markdown
        meson
        nginx
        ninja
        nix
        nu
        pod
        properties
        python
        ql
        qmldir
        regex
        rust
        scala
        scss
        sql
        ssh-config
        toml
        tsx
        twig
        typescript
        vim
        vimdoc
        xml
        yaml
        zsh
      ];
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        indent.enable = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-refactor = {
      enable = false; # XXX: broken
      settings = {
        highlight_definitions.enable = true;
      };
    };
    ts-autotag = {
      enable = true;
    };
  };
}
