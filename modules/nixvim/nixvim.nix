{ pkgs, ... }:
{

  imports = [
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins/gitsigns.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/lsp.nix
    ./plugins/conform.nix
    ./plugins/blink-cmp.nix
    ./plugins/todo-comments.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix
    ./plugins/debug.nix
    ./plugins/indent-blankline.nix
    ./plugins/lint.nix
    ./plugins/autopairs.nix
    ./plugins/neo-tree.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    colorschemes.oxocarbon.enable = true;

    diagnostic = {
      settings = {
        severity_sort = true;
        float = {
          border = "rounded";
          source = "if_many";
        };
        underline = {
          severity.__raw = "vim.diagnostic.severity.ERROR";
        };
        signs.__raw = ''
          vim.g.have_nerd_font and {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰅚 ',
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
          } or {}
        '';
        virtual_text = {
          source = "if_many";
          spacing = 2;
          format.__raw = ''
            function(diagnostic)
              local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
              }
              return diagnostic_message[diagnostic.severity]
            end
          '';
        };
      };
    };

    plugins = {
      # Adds icons for plugins to utilize in ui
      web-devicons.enable = true;

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      guess-indent = {
        enable = true;
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraplugins
    extraPlugins = with pkgs.vimPlugins; [
      # NOTE: This is where you would add a vim plugin that is not implemented in Nixvim, also see extraConfigLuaPre below
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html#extraconfigluapost
    extraConfigLuaPost = ''
      -- The line beneath this is called `modeline`. See `:help modeline`
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
