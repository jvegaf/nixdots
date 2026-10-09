{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        css
        dockerfile
        editorconfig
        gitignore
        json
        just
        lua
        markdown
        nix
        python
        rust
        ssh-config
        toml
        vim
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
