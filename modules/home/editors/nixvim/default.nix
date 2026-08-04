{ pkgs, inputs, ... }:
{

  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.nixvim = {
    imports = [
      ./keymaps.nix
      ./barbar.nix
      ./blink-cmp.nix
      ./comment.nix
      ./conform.nix
      ./dial.nix
      ./dropbar.nix
      ./flash.nix
      ./gitsigns.nix
      ./inc-rename.nix
      ./lsp.nix
      ./neogit.nix
      ./nvim-tree.nix
      ./sidekick.nix
      ./snacks.nix
      ./treesitter.nix
      ./treesj.nix
      ./trouble.nix
      ./whichkey.nix
      ./yanky.nix
    ];

    enable = true;

    nixpkgs.config.allowUnfree = true;

    enableMan = false;

    withRuby = false;

    colorscheme = "base16-ayu-dark";
    colorschemes = {
      base16 = {
        enable = true;
        colorscheme = "ayu-dark";
      };
    };

    performance = {
      byteCompileLua = {
        enable = true;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
    };

    globals = {
      mapleader = " ";
      timeoutlen = 500;
    };

    opts = {
      expandtab = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 4;
      cursorline = true;
      scrolloff = 5;
      visualbell = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      undofile = true;
      spell = false;
      foldlevel = 99;
      foldlevelstart = 99;
      list = true;
      updatetime = 2000;
      termguicolors = true;
    };

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xsel.enable = true;
        xclip.enable = true;
      };
    };

    plugins = {
      better-escape = {
        enable = true;
      };
      diffview = {
        enable = true;
        settings = {
          enhanced_diff_hl = true;
        };
      };
      fidget.enable = true;
      lastplace.enable = true;
      lualine = {
        enable = true;
        settings = {
          globalstatus = true;
          theme = "base16-ayu-dark";
        };
      };
      luasnip.enable = true;
      nix.enable = true;
      nix-develop.enable = true;
      markview.enable = true;
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };
      nvim-surround = {
        enable = true;
      };
      tmux-navigator.enable = true;
      lazygit.enable = true;
      nvim-ufo.enable = true;
      web-devicons.enable = true;
    };
  };
}
